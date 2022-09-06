class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :title, index: { unique: true }, null: false
      t.integer :total_upvotes, default: 0
      t.integer :total_downvotes, default: 0
      t.string :permalink, index: { unique: true }
      t.references :user, index: true, foreign_key: true
      t.timestamps
      t.timestamp :published_at
      t.timestamp :answered_at
    end
  end
end
