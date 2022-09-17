class CreditPacksController < ApplicationController
  def show
    @credit_packs = CreditPack.order(:price)
  end
end
