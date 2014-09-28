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
end
