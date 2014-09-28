json.array!(@activities) do |activity|
  activity = activity.decorate
  json.extract! activity, :id, :type
  json.message do
    # Sadly, this step is needed because extract doesn't find the at_in_words methods from the decorator.
    json.extract! activity.message, :id, :verb, :sender, :recipient, :acknowledged_at, :acknowledged_at_in_words, :created_at, :created_at_in_words
  end
end
