class CreditPack < ApplicationRecord
  validates :price, :credits, numericality: true
end
