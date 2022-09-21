class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :role, default: 1
      t.string :confirmation_token
      t.string :password_reset_token
      t.timestamp :verified_at
      t.timestamp :password_reset_at

      t.timestamps
    end
  end
end
