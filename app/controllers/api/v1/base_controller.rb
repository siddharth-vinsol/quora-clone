class Api::V1::BaseController < ApplicationController
  before_action :check_max_api_calls
  before_action :authorize
  after_action :generate_api_call_log

  private def authorize
    unless current_user
      render json: { error: t('invalid_auth_token') }, status: :unprocessable_entity
    end
  end

  private def current_user
    @logged_in_user ||= User.find_by(auth_token: params[:token])
  end

  private def check_max_api_calls
    api_call_count = ApiRequestLogs.where(ip_address: request.remote_ip, created_at: 1.hour.ago..Time.now).count

    if api_call_count >= QuoraClone::Api::V1::MAX_API_CALLS_PER_HOUR
      render json: { error: t('too_many_api_calls') }, status: :unprocessable_entity
    end
  end

  private def generate_api_call_log
    ApiRequestLogs.create(ip_address: request.remote_ip, endpoint: request.url)
  end
end
