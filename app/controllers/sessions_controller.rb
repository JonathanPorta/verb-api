class SessionsController < ApplicationController
  skip_before_action :require_authentication, only: [:create]

  def create
    logger.debug env['omniauth.auth']
    user = User.from_omniauth env['omniauth.auth']
    session[:user_id] = user.id
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  def show
    @user = current_user
  end

  def failure
    # TODO: Need to think about what should actually happen here.
    redirect_to root_url
  end
end
