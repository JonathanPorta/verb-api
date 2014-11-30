require 'rails_helper'

feature 'Get friends for user' do
  pending "add some examples to (or delete) #{__FILE__}"
  before :each do
    @user = FactoryGirl.create :user_with_facebook_auth
  end

  it 'with no friends using app' do
    @friends = @user.facebook_connections
    expect(@friends.count).to eq(0)
  end

  it 'with 1 friends using app' do
    @friend1 = FactoryGirl.create :user_with_facebook_auth
    @friend1.auth_providers.first.update uid: '123456789fake'
    @friend1.save

    @friends = @user.facebook_connections
    expect(@friends.count).to eq(1)
  end
end
