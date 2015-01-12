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

  describe 'Friend functions work as expected' do
    before :each do
      @user = FactoryGirl.create :user
      @friend = FactoryGirl.create :user
    end

    it 'Allows a user to view their sent, unaccepted friendship requests' do
      expect { @friendship = Friendship.create user: @user, friend: @friend }.to change(Friendship, :count).by(1)
      expect(@friendship).to be_a(Friendship)
      expect(@friendship).to be_persisted
      expect(@friendship.approved).to be_nil

      expect(@user.friendship_requests_sent.count).to eq(1)
      expect(@user.friendship_requests_sent.first).to be_a(Friendship)

      expect(@user.friendship_requests_sent.first).to eq(@friendship)
    end

    it 'Allows a user in receipt of a friend request to see those requests' do
      expect { @friendship = Friendship.create user: @friend, friend: @user }.to change(Friendship, :count).by(1)
      expect(@friendship).to be_a(Friendship)
      expect(@friendship).to be_persisted
      expect(@friendship.approved).to be_nil

      expect(@user.friendship_requests_received.count).to eq(1)
      expect(@user.friendship_requests_received.first).to be_a(Friendship)

      expect(@user.friendship_requests_received.first).to eq(@friendship)
    end

    it 'Allows a user to see friends, once the relationships have been accepted' do
      expect { @friendship = Friendship.create user: @user, friend: @friend }.to change(Friendship, :count).by(1)
      expect(@friendship).to be_a(Friendship)
      expect(@friendship).to be_persisted
      expect(@friendship.approved).to be_falsey

      # Accept the friendship request
      @friendship.accept

      # We should have one friend!
      expect(@user.all_friends.count).to eq(1)
      expect(@user.friends.first).to eq(@friend)
    end
  end

  describe 'User authentication' do
    before :each do
      @user = FactoryGirl.create :user
      @email = @user.email
      @password = @user.password
    end

    it 'Should authenticate a user and return a model' do
      user = User.authenticate @email, @password
      expect(user).to eq(@user)
    end
  end
end
