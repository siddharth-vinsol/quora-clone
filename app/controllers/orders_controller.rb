class OrdersController < ApplicationController
  before_action :set_credit_pack, only: [:create]
  before_action :set_order, only: [:checkout]

  def create
    @order = Order.find_or_initialize_by(amount: @credit_pack.price, status: 'in-cart', credit_pack: @credit_pack, user: current_user, status: 'in-cart')
    if @order.save
      redirect_to checkout_order_path(@order.id)
    else
      redirect_to credit_packs_path, notice: t('failed_order')
    end
  end

  def checkout
  end

  private def set_credit_pack
    @credit_pack = CreditPack.find(params[:pack_id])
  end

  private def set_order
    @order = Order.find(params[:id])
  end
end
