class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]

  rescue ActiveRecord::RecordNotFound => e
    # The user has an invalid session, so let's kill it off.
    logger.warn "A session was provided, but that user isn't in the database: #{ e }"
    redirect_to '/logout'
  end

  helper_method :current_user
end
