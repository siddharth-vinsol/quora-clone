class ChargesController < ApplicationController
  before_action :process_transaction, only: [:success]
  before_action :set_credit_pack, only: [:create, :success]
  before_action :setup_stripe_payment, only: [:create]
  before_action :update_user_credits, only: [:success]

  def new
  end

  def create
    redirect_to @payment_session.initiate_payment_session.url, allow_other_host: true
  end

  def success
  end

  private def set_credit_pack
    @credit_pack = CreditPack.find(params[:pack_id])
  end
  
  private def setup_stripe_payment
    @payment_session = StripeChargesService.new(@credit_pack, current_user)
  end

  private def process_transaction
    @payment_status = Stripe::Checkout::Session.retrieve({
      id: params[:transaction_id],
      expand: ['customer']
    })
    params[:pack_id] = @payment_status.metadata.credit_pack_id

  rescue Stripe::InvalidRequestError
    redirect_to credit_pack_path, notice: 'Invalid transaction.'
  end

  private def update_user_credits
    if @payment_status.payment_status == 'paid'
      current_user.update_credits(@credit_pack.credits, @credit_pack, 'Purchased Pack')
    end
  end
end
