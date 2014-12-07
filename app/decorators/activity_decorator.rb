class ActivityDecorator < Draper::Decorator
  delegate :id, :user, :actionable, :type, :actionable_type

  decorates_association :user
  decorates_association :actionable

  def reciprocate_message
    actionable.unacknowledged_message_for_sender_reciprocation
  end

  def acknowledge_message
    actionable.acknowledged_message_for_recipient
  end

  def activity_message
    if object.type == 'sent'
      if actionable.acknowledged_at
        actionable.acknowledged_message_for_sender
      else
        actionable.unacknowledged_message_for_sender
      end
    else
      if actionable.acknowledged_at
        actionable.acknowledged_message_for_recipient
      else
        actionable.unacknowledged_message_for_recipient
      end
    end
  end
end
