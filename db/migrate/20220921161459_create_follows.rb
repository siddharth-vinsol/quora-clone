class CreateFollows < ActiveRecord::Migration[7.0]
  def change
    create_table :follows, primary_key: [:followee_id, :follower_id] do |t|
      t.references :followee, null: false, foreign_key: { to_table: :users }
      t.references :follower, null: false, foreign_key: { to_table: :users }
    end
  end
end
