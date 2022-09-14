class AddColumnsToAnswers < ActiveRecord::Migration[7.0]
  def change
    change_table :answers do |t|
      t.column :total_upvotes, :integer, default: 0
      t.column :total_downvotes, :integer, default: 0
    end
  end
end
