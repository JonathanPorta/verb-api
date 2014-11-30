class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  private

  def current_user
    # logger.debug request.headers.inspect
    logger.debug request.headers['HTTP_ACCESS_TOKEN']
    # logger.debug request.headers['access_token']
    if session[:user_id]
      logger.warn 'Getting user because the session had a user_id.'
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    elsif request.headers['HTTP_ACCESS_TOKEN']
      logger.warn 'Getting user because request had an access token.'
      @urrent_user ||= User.find_by_access_token request.headers['HTTP_ACCESS_TOKEN']
    end

  rescue ActiveRecord::RecordNotFound => e
    # The user has an invalid session, so let's kill it off.
    logger.warn "A session was provided, but that user isn't in the database: #{ e }"
    redirect_to '/logout'
  end

  helper_method :current_user
end
