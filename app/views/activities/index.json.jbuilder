json.array!(@activities) do |activity|
  json.extract! activity, :id, :user_id, :message_id, :acknowledged_at, :body
  json.url activity_url(activity, format: :json)
end