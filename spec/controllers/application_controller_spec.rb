require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

  # Anonymous controller stub, FTW!
  controller do
    def index
      @current_user = current_user
      render text: 'Just a test, bro!'
    end
  end

  before :each do
    @user = FactoryGirl.create :user_with_facebook_auth
    @valid_auth_token = @user.api_token
    @invalid_auth_toke = 'INVALIDAUTHTOKEN'
  end

  let(:valid_session) { { user_id: @user.id } }

  describe 'Test current_user helper' do

    it 'returns correct user when valid session exists' do
      request.session[:user_id] = @user.id
      get :index, {}
      expect(assigns(:current_user)).to eq(@user)
    end

    it 'returns correct user when valid header token is set' do
      request.headers['HTTP_API_TOKEN'] = @valid_auth_token
      get :index, {}
      expect(assigns(:current_user)).to eq(@user)
    end

    it 'returns nil when invalid header token is set' do
      request.headers['HTTP_API_TOKEN'] = @invalid_auth_token
      get :index, {}
      expect(assigns(:current_user)).to eq(nil)
    end
  end
end
