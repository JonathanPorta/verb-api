class SessionsController < ApplicationController
  skip_before_action :require_authentication, only: [:create, :login]

  # GET /auth/:provider/callback
  def create
    logger.debug env['omniauth.auth']
    user = User.from_omniauth env['omniauth.auth']
    current_session user
    redirect_to root_url
  end

  # POST /login
  def login
    user = User.authenticate login_params[:email], login_params[:password]
    current_session user
    redirect_to root_url
  end

  # GET /logout
  def destroy
    current_session nil
    redirect_to root_url
  end

  # GET /user
  def show
    @user = current_user
  end

  def failure
    # TODO: Need to think about what should actually happen here.
    redirect_to root_url
  end

  private

  def current_session(user)
    if user
      session[:user_id] = user.id
    else
      session[:user_id] = nil
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def login_params
    params.permit(:email, :password)
  end
end
