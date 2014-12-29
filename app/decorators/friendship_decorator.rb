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
    "You became friends with #{ friend.first_name }."
  end

  def acknowledged_message_for_recipient
    "You became friends with #{ user.first_name }." # past tense
  end

  def unacknowledged_message_for_sender
    "You sent #{ friend.first_name } a friend request." # present
  end

  def unacknowledged_message_for_recipient
    "#{ user.first_name } sent you a friend request." # present
  end

  def unacknowledged_message_for_sender_reciprocation
    # TODO: How to handle this case?
    '' # present
  end
end
