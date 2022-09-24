class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.string :content
      t.boolean :sent
      t.string :redirect_link
      t.references :notifiable, null: false, polymorphic: true
      t.references :user, null: false, foreign_key: true
      t.timestamp :created_at, null: false
    end
  end
end
