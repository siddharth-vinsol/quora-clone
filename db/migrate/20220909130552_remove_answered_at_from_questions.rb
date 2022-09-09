class RemoveAnsweredAtFromQuestions < ActiveRecord::Migration[7.0]
  def change
    remove_column :questions, :answered_at, :timestamp
  end
end
