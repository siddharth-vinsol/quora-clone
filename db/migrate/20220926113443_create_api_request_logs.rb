class CreateApiRequestLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :api_request_logs do |t|
      t.string :endpoint
      t.string :ip_address
      t.timestamp :created_at
    end
  end
end
