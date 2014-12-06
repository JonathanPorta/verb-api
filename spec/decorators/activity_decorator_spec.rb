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

    it 'decorates actionable association with MessageDecorator' do
      expect(@sender.activities.first.decorate.actionable).to be_a(FriendshipDecorator)
    end
  end
end

# def reciprocate_message
#   unacknowledged_message_for_sender_reciprocation
# end
#
# def acknowledge_message
#   acknowledged_message_for_recipient
# end
#
# def acknowledged_message_for_sender
#   "You #{ conjugate_verb(:past, :perfective) } #{ recipient.first_name }." # past tense
# end
#
# def acknowledged_message_for_recipient
#   "#{ sender.first_name } #{ conjugate_verb(:past, :perfective) } you." # past tense
# end
#
# def unacknowledged_message_for_sender
#   "You tried to #{ verb } #{ recipient.first_name }." # present
# end
#
# def unacknowledged_message_for_recipient
#   "#{ sender.first_name } wants to #{ verb } you." # present
# end
#
# def unacknowledged_message_for_sender_reciprocation
#   "You tried to #{ verb } #{ sender.first_name }." # present
# end
