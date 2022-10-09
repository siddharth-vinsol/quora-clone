class CreateCreditPacks < ActiveRecord::Migration[7.0]
  def change
    create_table :credit_packs do |t|
      t.decimal :price, scale: 2, precision: 8
      t.integer :credits

      t.timestamps
    end
  end
end
