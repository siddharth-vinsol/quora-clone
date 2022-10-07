class CreditTransaction < ApplicationRecord
  belongs_to :user
  belongs_to :entity, polymorphic: true, optional: true

  enum transaction_type: {
    debit: 0,
    credit: 1
  }

  validates :value, numericality: { greater_than_or_equal_to: 0 }
  validates :transaction_type, inclusion: transaction_types.keys
end
