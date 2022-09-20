class CreditPacksController < ApplicationController
  def index
    @credit_packs = CreditPack.order(:price)
  end
end
