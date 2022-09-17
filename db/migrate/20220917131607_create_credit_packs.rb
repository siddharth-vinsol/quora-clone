class CreateCreditPacks < ActiveRecord::Migration[7.0]
  def change
    create_table :credit_packs do |t|
      t.integer :price
      t.integer :credits

      t.timestamps
    end
  end
end
