require 'rails_helper'

RSpec.describe 'Activities', type: :request do
  describe 'GET /activities' do
    it 'works! (now write some real specs)' do
      login_with_oauth

      get activities_path
      expect(response.status).to be(200)
    end
  end
end
