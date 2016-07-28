class ApplicationController < ActionController::API
  include JSONAPI::ActsAsResourceController

  before_action :verify_auth_token

  def verify_auth_token
    @api_user ||= ApiUser.where(auth_token: request.headers['X-API-KEY'])
    if @api_user.empty?
      render json: { error: 'Forbidden' }, status: 403
    end
  end
end
