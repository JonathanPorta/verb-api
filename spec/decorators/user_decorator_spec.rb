require 'rails_helper'

RSpec.describe UserDecorator, type: :decorator do
  before :each do
    @user = FactoryGirl.create :user
    @friend = FactoryGirl.create :user

    @decorated_user = UserDecorator.new @user
    @decorated_friend = UserDecorator.new @friend
  end

  it 'Generates proper relationship statuses for an unaccepted relationship' do
    # Build our unapproved relationship
    expect { @friendship = Friendship.create user: @user, friend: @friend }.to change(Friendship, :count).by(1)
    expect(@friendship.approved).to be_nil

    # Make sure both sides see the correct 'friendship request' status.
    expect(@decorated_user.relationship @decorated_friend).to eq('friendship requested')
    expect(@decorated_friend.relationship @decorated_user).to eq('friendship received')
  end

  it 'Generates proper relationship statuses for an accepted relationship' do
    # Build our unapproved relationship
    expect { @friendship = Friendship.create user: @user, friend: @friend }.to change(Friendship, :count).by(1)
    expect(@friendship.approved).to be_nil

    @friendship.accept
    expect(@friendship.approved).to be_truthy
    expect(@friendship.valid?).to be_truthy

    # Make sure both sides see the correct 'friendship request' status.
    expect(@decorated_user.relationship @decorated_friend).to eq('friends')
    expect(@decorated_friend.relationship @decorated_user).to eq('friends')
  end

  it 'Generates proper relationship statuses when there is no relationship' do
    expect(@decorated_user.relationship @decorated_friend).to eq('not friends')
    expect(@decorated_friend.relationship @decorated_user).to eq('not friends')
  end
end
