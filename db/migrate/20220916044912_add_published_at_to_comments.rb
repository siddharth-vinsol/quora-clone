class AddPublishedAtToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :published_at, :timestamp
  end
end
