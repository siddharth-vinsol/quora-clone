class AddDisabledAtToAnswers < ActiveRecord::Migration[7.0]
  def change
    add_column :answers, :disabled_at, :timestamp
  end
end
