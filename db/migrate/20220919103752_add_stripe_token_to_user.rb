class AddStripeTokenToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :stripe_token, :string
  end
end
