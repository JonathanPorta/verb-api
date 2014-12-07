json.array!(@activities) do |activity|
  activity = activity.decorate
  json.extract! activity, :id, :type, :activity_message

  if activity.type == 'received'
    json.reciprocate_message activity.reciprocate_message
    json.acknowledge_message activity.acknowledge_message
  end

  json.actionable do
    if activity.actionable_type == 'Message'
      json.extract! activity.actionable, :id, :verb, :sender, :recipient, :acknowledged_at, :acknowledged_at_in_words, :created_at, :created_at_in_words
    else
      json.extract! activity.actionable, :id, :user, :friend, :acknowledged_at, :acknowledged_at_in_words, :created_at, :created_at_in_words
    end

    json.type activity.actionable_type
  end
end
