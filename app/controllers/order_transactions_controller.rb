class OrderTransactionsController < ApplicationController
  before_action :process_transaction, only: [:success, :failure]
  before_action :set_order, only: [:create, :success, :failure]
  before_action :generate_transaction, only: [:success, :failure]
  before_action :setup_stripe_payment, only: [:create]
  before_action :update_user_credits, only: [:success]

  def new
  end

  def create
    redirect_to @payment_session.initiate_payment_session.url, allow_other_host: true
  end

  def success
  end

  def failure
  end

  private def set_order
    @order = Order.find(params[:order_id])
  end
  
  private def setup_stripe_payment
    @payment_session = StripeChargesService.new(@order, current_user)
  end

  private def process_transaction
    @payment_status = Stripe::Checkout::Session.retrieve({
      id: params[:transaction_id],
      expand: ['customer']
    })
    params[:order_id] = @payment_status.metadata.order_id

  rescue Stripe::InvalidRequestError
    redirect_to credit_packs_path, notice: t('invalid_transaction')
  end

  private def update_user_credits
    if @payment_status.payment_status == 'paid'
      current_user.update_credits(@order.credit_pack.credits, @order, 'Purchased Pack')
    end
  end

  private def generate_transaction
    @order_transaction = OrderTransaction.find_or_initialize_by(transaction_id: @payment_status.id) do |transaction|
      transaction.order = @order
      transaction.amount = @payment_status.amount_total
      transaction.payment_method = @payment_status.payment_method_types[0]
      transaction.payment_status = @payment_status.payment_status
      # transaction.reason
    end

    if @order_transaction.persisted?
      redirect_to credit_packs_path, notice: t('already_redeemed') 
    else
      @order_transaction.save
    end
  end
end
