class Api::V1::BaseController < ApplicationController
  before_action :authorize

  def authorize
    unless current_user
      render json: { error: t('invalid_auth_token') }, status: :unprocessable_entity
    end
  end

  def current_user
    @logged_in_user ||= User.find_by(auth_token: params[:token])
  end
end
