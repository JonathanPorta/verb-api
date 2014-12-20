require 'rails_helper'

RSpec.describe Friendship, type: :model do
  before :each do
    @user = FactoryGirl.create :user
    @friend = FactoryGirl.create :user
  end

  it 'Creates new friendship' do
    expect { @friendship = Friendship.create user: @user, friend: @friend }.to change(Friendship, :count).by(1)
    expect(@friendship).to be_a(Friendship)
    expect(@friendship).to be_persisted
  end

  it 'Creates a new friendship that is not approved yet' do
    expect { @friendship = Friendship.create user: @user, friend: @friend }.to change(Friendship, :count).by(1)
    expect(@friendship).to be_a(Friendship)
    expect(@friendship).to be_persisted
    expect(@friendship.approved).to be_nil
  end

  it 'Does not allow a duplicate friendship to be created' do
    expect { @friendship1 = Friendship.create user: @user, friend: @friend }.to change(Friendship, :count).by(1)
    expect { @friendship2 = Friendship.create user: @user, friend: @friend }.to change(Friendship, :count).by(0)
  end

  it 'Does not allow the same inverse friendship to be created' do
    expect { @friendship1 = Friendship.create user: @user, friend: @friend }.to change(Friendship, :count).by(1)
    expect { @friendship2 = Friendship.create user: @friend, friend: @user }.to change(Friendship, :count).by(0)
  end

  it 'Allows a new friendship to be accepted' do
    expect { @friendship = Friendship.create user: @user, friend: @friend }.to change(Friendship, :count).by(1)
    expect(@friendship).to be_a(Friendship)
    expect(@friendship).to be_persisted
    expect(@friendship.approved).to be_nil
    @friendship.accept
    expect(@friendship.approved).to be_truthy
    expect(@friendship.valid?).to be_truthy
  end

  it 'Does not allow a user to friend themselves' do
    expect { @friendship = Friendship.create user: @user, friend: @user }.to change(Friendship, :count).by(0)
    expect(@friendship.valid?).to be_falsey
  end
end
