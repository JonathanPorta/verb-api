class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:show, :edit, :update, :destroy, :accept]

  # GET /friendships
  # GET /friendships.json
  def index
    @friendships = current_user.friendships + current_user.inverse_friendships
  end

  # GET /friendships/1
  # GET /friendships/1.json
  def show
  end

  # GET /friendships/new
  def new
    @friendship = Friendship.new user: current_user
  end

  # GET /friendships/1/edit
  def edit
  end

  # GET /friendships/1/accept
  def accept
    # Can only accept requests sent to current_user
    if @friendship.friend == current_user
      @friendship.accept
      render :show, status: :ok
    else
      render json: @friendship.errors, status: :unprocessable_entity
    end
  end

  # GET /friendships/requests
  def requests
    @friendships = current_user.friendship_requests_received
  end

  # GET /friendships/requested
  def requested
    @friendships = current_user.friendship_requests_sent
  end

  # POST /friendships
  # POST /friendships.json
  def create
    @friendship = Friendship.new(user: current_user, friend_id: friendship_params[:friend_id])

    respond_to do |format|
      if @friendship.save
        format.html { redirect_to @friendship, notice: 'Friendship was successfully created.' }
        format.json { render :show, status: :created, location: @friendship }
      else
        format.html { render :new }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friendships/1
  # PATCH/PUT /friendships/1.json
  def update
    respond_to do |format|
      if @friendship.update(friendship_params)
        format.html { redirect_to @friendship, notice: 'Friendship was successfully updated.' }
        format.json { render :show, status: :ok, location: @friendship }
      else
        format.html { render :edit }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friendships/1
  # DELETE /friendships/1.json
  def destroy
    @friendship.destroy
    respond_to do |format|
      format.html { redirect_to friendships_url, notice: 'Friendship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def friendship_params
    params.require(:friendship).permit(:friend_id)
  end
end
