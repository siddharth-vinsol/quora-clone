class AddDisabledAtToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :disabled_at, :timestamp
  end
end
