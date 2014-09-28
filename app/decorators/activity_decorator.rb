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
    elsif object.type == 'received'
      if message.acknowledged_at
        acknowledged_message_for_recipient
      else
        unacknowledged_message_for_recipient
      end
    end
  end

  private

  def acknowledged_message_for_sender
    "You did #{ message.verb } #{ message.recipient.first_name }!"
  end

  def acknowledged_message_for_recipient
    "#{ message.sender.first_name } did #{ message.verb } you!"
  end

  def unacknowledged_message_for_sender
    "You tried to #{ message.verb } #{ message.recipient.first_name }!"
  end

  def unacknowledged_message_for_recipient
    "#{ message.sender.first_name } wants to #{ message.verb } you!"
  end
end
