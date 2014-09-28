json.array!(@messages) do |message|
  json.extract! message, :id, :sender_id, :recipient_id, :acknowledged_at, :verb
  json.url message_url(message, format: :json)
end
