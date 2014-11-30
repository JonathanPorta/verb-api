require 'rails_helper'

RSpec.describe 'Friendships', type: :request do
  describe 'GET /friendships' do
    it 'works! (now write some real specs)' do
      login_with_oauth
      get friendships_path
      expect(response.status).to be(200)
    end
  end
end
