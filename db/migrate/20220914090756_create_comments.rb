class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :content, null: false
      t.references :commentable, polymorphic: true, null: false
      t.string :total_upvotes, default: 0
      t.string :total_downvotes, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
