class FriendsController < ApplicationController
  def index
    @friends = current_user.all_friends
  end

  def facebook
    @friends = current_user.facebook_connections
  end
end
