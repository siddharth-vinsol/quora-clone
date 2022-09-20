class Order < ApplicationRecord
  enum status: {
    'in-cart' => 0,
    'pending' => 1,
    'cancelled' => 2,
    'failed' => 3,
    'success' => 4
  }

  belongs_to :credit_pack
  belongs_to :user

  validates :amount, :status, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :status, inclusion: statuses.keys
end
