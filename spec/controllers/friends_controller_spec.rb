require 'rails_helper'

RSpec.describe FriendsController, type: :controller do
  before :each do
    @sender = FactoryGirl.create :user
    request.session[:user_id] = @sender.id
  end

  describe 'GET index.json' do
    pending "Figure out how to mock facebook api calls in #{__FILE__}"
  end
end
