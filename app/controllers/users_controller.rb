class UsersController < ApplicationController
  before_action :set_user, only: []
  skip_before_action :require_authentication, only: [:create]

  # POST /users.json
  def create
    @user = User.new user_params

    if @user.save
      render :show, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
