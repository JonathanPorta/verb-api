require 'rails_helper'

RSpec.describe FriendsController, :type => :controller do

  describe "GET index.json" do
    it "returns http success" do
      get :index.json
      expect(response).to be_success
    end
  end

end
