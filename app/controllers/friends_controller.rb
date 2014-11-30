class FriendsController < ApplicationController
  def index
    @friends = current_user.all_friends
  end
end
