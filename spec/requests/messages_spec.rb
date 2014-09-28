require 'rails_helper'

RSpec.describe "Messages", :type => :request do
  describe "GET /messages" do
    it "works! (now write some real specs)" do
      login_with_oauth
  
      get messages_path
      expect(response.status).to be(200)
    end
  end
end
