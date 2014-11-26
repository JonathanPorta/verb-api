class ActivityDecorator < Draper::Decorator
  delegate :id, :user, :message, :type

  decorates_association :user
  decorates_association :message

  def activity_message
    # hashtag uhg.
    if object.type == 'sent'
      if message.acknowledged_at
        acknowledged_message_for_sender
      else
        unacknowledged_message_for_sender
      end
    else
      if message.acknowledged_at
        acknowledged_message_for_recipient
      else
        unacknowledged_message_for_recipient
      end
    end
  end

  def reciprocate_message
    unacknowledged_message_for_sender_reciprocation
  end

  def acknowledge_message
    acknowledged_message_for_recipient
  end

  private

  def acknowledged_message_for_sender
    "You #{ message.conjugate_verb(:past, :perfective) } #{ message.recipient.first_name }." # past tense
  end

  def acknowledged_message_for_recipient
    "#{ message.sender.first_name } #{ message.conjugate_verb(:past, :perfective) } you." # past tense
  end

  def unacknowledged_message_for_sender
    "You tried to #{ message.verb } #{ message.recipient.first_name }." # present
  end

  def unacknowledged_message_for_recipient
    "#{ message.sender.first_name } wants to #{ message.verb } you." # present
  end

  def unacknowledged_message_for_sender_reciprocation
    "You tried to #{ message.verb } #{ message.sender.first_name }." # present
  end
end
