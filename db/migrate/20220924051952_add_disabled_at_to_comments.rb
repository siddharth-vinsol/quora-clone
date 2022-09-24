class AddDisabledAtToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :disabled_at, :timestamp
  end
end
