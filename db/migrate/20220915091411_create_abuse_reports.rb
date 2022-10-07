class CreateAbuseReports < ActiveRecord::Migration[7.0]
  def change
    create_table :abuse_reports do |t|
      t.references :abuse_reportable, polymorphic: true, null: false
      t.string :reason, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
