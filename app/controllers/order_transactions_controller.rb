class OrderTransactionsController < ApplicationController
  before_action :set_order, only: [:create]
  before_action :setup_stripe_payment, only: [:create]

  def new
  end

  def create
    redirect_to @payment_session.initiate_payment_session.url, allow_other_host: true
  end

  private def set_order
    @order = Order.find(params[:order_id])
  end
  
  private def setup_stripe_payment
    @payment_session = StripeChargesService.new(@order, current_user)
  end
end
