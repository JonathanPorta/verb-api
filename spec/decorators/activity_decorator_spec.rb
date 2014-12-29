require 'rails_helper'

describe ActivityDecorator do

  describe 'activity for message in sender context' do
    before :each do
      @sender = FactoryGirl.create :user
      @recipient = FactoryGirl.create :user

      @message = Message.create!(
        sender: @sender,
        recipient: @recipient,
        verb: 'hug'
      )
    end

    it 'decorates user association with UserDecorator' do
      expect(@sender.activities.first.decorate.user).to be_a(UserDecorator)
    end

    it 'decorates actionable association with MessageDecorator' do
      expect(@sender.activities.first.decorate.actionable).to be_a(MessageDecorator)
    end

    it 'provides correct activity message for sender when message is unacknowledged' do
      expect(@sender.activities.first.decorate.activity_message).to eq("You tried to hug #{ @recipient.first_name }.")
    end

    it 'provides correct activity message for sender when message is acknowledged' do
      @message.acknowledge
      expect(@sender.activities.first.decorate.activity_message).to eq("You hugged #{ @recipient.first_name }.")
    end
  end

  describe 'activity for message in recipient context' do
    before :each do
      @sender = FactoryGirl.create :user
      @recipient = FactoryGirl.create :user

      @message = Message.create!(
      sender: @sender,
      recipient: @recipient,
      verb: 'hug'
      )
    end

    it 'decorates user association with UserDecorator' do
      expect(@recipient.activities.first.decorate.user).to be_a(UserDecorator)
    end

    it 'decorates actionable association with MessageDecorator' do
      expect(@recipient.activities.first.decorate.actionable).to be_a(MessageDecorator)
    end

    it 'provides correct reciprocate activity message if recipient were to reciprocate' do
      expect(@recipient.activities.first.decorate.reciprocate_message).to eq("You tried to hug #{ @sender.first_name }.")
    end

    it 'provides correct acknowledge activity message if recipient were to acknowledge' do
      expect(@recipient.activities.first.decorate.acknowledge_message).to eq("#{ @sender.first_name } hugged you.")
    end

    it 'provides correct activity message for recipient when message is unacknowledged' do
      expect(@recipient.activities.first.decorate.activity_message).to eq("#{ @sender.first_name } wants to hug you.")
    end

    it 'provides correct activity message for recipient when message is acknowledged' do
      @message.acknowledge
      expect(@recipient.activities.first.decorate.activity_message).to eq("#{ @sender.first_name } hugged you.")
    end
  end

  describe 'activity for friendship in sender context' do
    before :each do
      @sender = FactoryGirl.create :user
      @recipient = FactoryGirl.create :user

      @friendship = Friendship.create!(
        user: @sender,
        friend: @recipient
      )
    end

    it 'decorates user association with UserDecorator' do
      expect(@sender.activities.first.decorate.user).to be_a(UserDecorator)
    end

    it 'decorates actionable association with FriendshipDecorator' do
      expect(@sender.activities.first.decorate.actionable).to be_a(FriendshipDecorator)
    end

    it 'provides correct reciprocate activity message if recipient were to reciprocate' do
      expect(@recipient.activities.first.decorate.reciprocate_message).to eq('')
    end

    it 'provides correct acknowledge activity message if recipient were to acknowledge' do
      expect(@recipient.activities.first.decorate.acknowledge_message).to eq("You accepted #{ @sender.first_name } friendship.")
    end

    it 'provides correct activity message for sender when friendship is unacknowledged' do
      expect(@sender.activities.first.decorate.activity_message).to eq("You offered friendship to #{ @recipient.first_name }.")
    end

    it 'provides correct activity message for sender when friendship is acknowledged' do
      @friendship.accept
      expect(@sender.activities.first.decorate.activity_message).to eq("#{ @recipient.first_name } accepted your friendship.")
    end
  end

  describe 'activity for friendship in recipient context' do
    before :each do
      @sender = FactoryGirl.create :user
      @recipient = FactoryGirl.create :user

      @friendship = Friendship.create!(
      user: @sender,
      friend: @recipient
      )
    end

    it 'decorates user association with UserDecorator' do
      expect(@recipient.activities.first.decorate.user).to be_a(UserDecorator)
    end

    it 'decorates actionable association with FriendshipDecorator' do
      expect(@recipient.activities.first.decorate.actionable).to be_a(FriendshipDecorator)
    end

    it 'provides correct activity message for recipient when friendship is unacknowledged' do
      expect(@recipient.activities.first.decorate.activity_message).to eq("#{ @sender.first_name } offers friendship.")
    end

    it 'provides correct activity message for recipient when friendship is acknowledged' do
      @friendship.accept
      expect(@recipient.activities.first.decorate.activity_message).to eq("You accepted #{ @sender.first_name } friendship.")
    end
  end
end
