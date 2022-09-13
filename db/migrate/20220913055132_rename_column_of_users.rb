class RenameColumnOfUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :password_reset_at, :reset_password_sent_at
  end
end
