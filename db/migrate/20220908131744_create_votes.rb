class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :voteable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
