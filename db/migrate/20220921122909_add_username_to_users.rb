class AddUsernameToUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.column :username, :string, index: { unique: true }
    end
  end
end
