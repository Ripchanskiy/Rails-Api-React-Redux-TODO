class ApplicationController < ActionController::API
  before_action :authenticate_request

  include ExceptionHandler

  private

  def authenticate_request
    @current_user ||= AuthorizeApiRequest.call(token: request.headers['Authorization']).user
  end
end
