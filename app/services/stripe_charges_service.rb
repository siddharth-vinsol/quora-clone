class StripeChargesService
  DEFAULT_CURRENCY = 'inr'.freeze
  PAYMENT_SUCCESS_URL = 'http://127.0.0.1:3000/order_transactions/success?transaction_id={CHECKOUT_SESSION_ID}'
  PAYMENT_FAILED_URL = 'http://127.0.0.1:3000/credit_pack'

  def initialize(order, user)
    @order = order
    @user = user
  end

  def initiate_payment_session
    payment_session = Stripe::Checkout::Session.create({
      line_items: [{
        price: generate_credit_pack_price_id,
        quantity: 1
      }],
      mode: 'payment',
      success_url: PAYMENT_SUCCESS_URL,
      cancel_url: PAYMENT_FAILED_URL,
      metadata: { order_id: @order.id }
    })
  end

  private def generate_credit_pack_price_id
    stripe_credit_pack = Stripe::Product::create({ name: 'Credit Pack' })
    Stripe::Price.create({ product: stripe_credit_pack.id, unit_amount_decimal: @order.credit_pack.price * 100, currency: DEFAULT_CURRENCY }).id
  end
end
