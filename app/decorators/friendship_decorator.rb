class FriendshipDecorator < Draper::Decorator
  delegate :id, :user, :friend

  decorates_association :user
  decorates_association :friend

  def created_at
    object.created_at.to_time.to_i
  end

  def created_at_in_words
    helpers.time_ago_in_words object.created_at
  end

  def acknowledged_at
    return nil unless object.approved
    object.approved.to_time.to_i
  end

  def acknowledged_at_in_words
    return nil unless object.approved
    helpers.time_ago_in_words object.approved
  end

  def reciprocate_message
    unacknowledged_message_for_sender_reciprocation
  end

  def acknowledge_message
    acknowledged_message_for_recipient
  end

  def acknowledged_message_for_sender
    "#{ friend.first_name } accepted your friendship."
  end

  def acknowledged_message_for_recipient
    "You accepted #{ user.first_name } friendship." # past tense
  end

  def unacknowledged_message_for_sender
    "You offered friendship to #{ friend.first_name }." # present
  end

  def unacknowledged_message_for_recipient
    "#{ user.first_name } offers friendship." # present
  end

  def unacknowledged_message_for_sender_reciprocation
    # TODO: How to handle this case?
    '' # present
  end
end
