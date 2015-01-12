class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :require_authentication
  # protect_from_forgery with: :null_session

  private

  def api_token
    logger.debug request.headers['HTTP_API_TOKEN']
    request.headers['HTTP_API_TOKEN']
  end

  def api_version
    request.headers['HTTP_API_VERSION']
  end

  def current_user
    if session[:user_id]
      logger.warn 'Getting user because the session had a user_id.'
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    elsif api_token
      logger.warn 'Getting user because request had an access token.'
      @current_user ||= User.authenticate_by_api_token api_token
    end

  rescue ActiveRecord::RecordNotFound => e
    # The user has an invalid session, so let's kill it off.
    logger.warn "A session was provided, but that user isn't in the database: #{ e }"
    redirect_to '/logout'
  end

  def require_authentication
    unauthorized unless current_user
  end

  def unauthorized
    render nothing: true, status: 401
  end

  helper_method :current_user
end
