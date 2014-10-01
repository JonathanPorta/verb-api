require 'rails_helper'

RSpec.describe 'Messages', type: :request do
  describe 'GET /messages' do
    it 'should redirect to /activities' do
      login_with_oauth

      get messages_path

      expect(response.status).to be(301)
    end
  end
end
