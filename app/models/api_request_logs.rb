class ApiRequestLogs < ApplicationRecord
  validates :endpoint, :ip_address, presence: true
end
