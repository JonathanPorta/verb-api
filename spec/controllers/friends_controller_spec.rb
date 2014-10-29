require 'rails_helper'

RSpec.describe FriendsController, type: :controller do
  before :each do
    @sender = FactoryGirl.create :user
    request.session[:user_id] = @sender.id
  end

  describe 'GET index.json' do
    it 'returns http success' do
      get :index.json
      expect(response).to be_success
    end
  end
end
