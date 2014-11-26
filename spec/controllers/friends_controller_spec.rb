require 'rails_helper'

RSpec.describe FriendsController, type: :controller do
  before :each do
    @user = FactoryGirl.create :user
    request.session[:user_id] = @user.id
    request.accept = 'application/json'
  end

  let(:valid_session) { { user_id: @user.id } }

  describe 'GET index.json' do
    it 'assigns all friends as @friends' do
      friends = @user.friends
      get :index, valid_session
      expect(assigns(:friends)).to eq(friends)
    end
  end
end
