class CreateCreateCreditTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :credit_transactions do |t|
      t.integer :value, null: false
      t.string :reason
      t.integer :transaction_type, null: false
      t.references :user, foreign_key: true
      t.references :entity, polymorphic: true
      t.timestamps
    end
  end
end
