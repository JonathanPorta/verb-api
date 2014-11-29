require 'rails_helper'

RSpec.describe "AuthProviders", type: :request do
  describe "GET /auth_providers" do
    it "works! (now write some real specs)" do
      get auth_providers_path
      expect(response.status).to be(200)
    end
  end
end
