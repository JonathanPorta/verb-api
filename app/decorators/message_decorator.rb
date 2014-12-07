class MessageDecorator < Draper::Decorator
  delegate :id, :sender, :recipient, :verb

  # Why can't you specify these on one line separated by comma like the delegate method?
  decorates_association :sender
  decorates_association :recipient

  # Since we don't delegate created/acknowledged_at we will override it here and they'll never know! Muahaha!
  def created_at
    object.created_at.to_time.to_i
  end

  def created_at_in_words
    helpers.time_ago_in_words object.created_at
  end

  def acknowledged_at
    return nil unless object.acknowledged_at
    object.acknowledged_at.to_time.to_i
  end

  def acknowledged_at_in_words
    return nil unless object.acknowledged_at
    helpers.time_ago_in_words object.acknowledged_at
  end

  def conjugate_verb(tense, aspect)
    Verbs::Conjugator.conjugate "#{ verb }", tense: tense, aspect: aspect
  end

  def reciprocate_message
    unacknowledged_message_for_sender_reciprocation
  end

  def acknowledge_message
    acknowledged_message_for_recipient
  end

  def acknowledged_message_for_sender
    "You #{ conjugate_verb(:past, :perfective) } #{ recipient.first_name }." # past tense
  end

  def acknowledged_message_for_recipient
    "#{ sender.first_name } #{ conjugate_verb(:past, :perfective) } you." # past tense
  end

  def unacknowledged_message_for_sender
    "You tried to #{ verb } #{ recipient.first_name }." # present
  end

  def unacknowledged_message_for_recipient
    "#{ sender.first_name } wants to #{ verb } you." # present
  end

  def unacknowledged_message_for_sender_reciprocation
    "You tried to #{ verb } #{ sender.first_name }." # present
  end
end
