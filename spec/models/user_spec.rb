require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Initialize a user object from omniauth-facebook' do
    before :each do
      @user_hash = omniauth_hash_mock
    end

    it 'new user' do
      expect { @user = User.from_omniauth @user_hash }.to change(User, :count).by(1)
      expect(@user).to be_a(User)
      expect(@user).to be_persisted
    end

    it 'existing user' do
      # Make sure user is already in the DB
      User.from_omniauth @user_hash

      expect { @user = User.from_omniauth @user_hash }.to change(User, :count).by(0)
      expect(@user).to be_a(User)
      expect(@user).to be_persisted
    end

    it 'existing user with new access_token' do
      # Make sure user is already in the DB
      User.from_omniauth @user_hash
      @user_hash.credentials.token = 'newandevenmorefaketoken'

      expect { @user = User.from_omniauth @user_hash }.to change(User, :count).by(0)
      expect(@user).to be_a(User)
      expect(@user).to be_persisted
      expect(@user.auth_providers.where(provider: 'facebook').first.token).to eq('newandevenmorefaketoken')
    end
  end
end
