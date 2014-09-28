json.array!(@activities) do |activity|
  json.extract! activity, :id, :user_id, :message_id, :acknowledged_at, :type
  json.message do
    json.extract! activity.message, :id, :sender_id, :recipient_id, :acknowledged_at, :body, :created_at, :updated_at
  end

  # If this was sent by the user, we need the info for who they sent it to.
  if activity.type == 'sent'
    json.recipient do
      json.extract! activity.message.recipient, :id, :first_name, :last_name, :name, :email
    end
  elsif activity.type == 'received'
    json.sender do
      json.extract! activity.message.sender, :id, :first_name, :last_name, :name, :email
    end
  end

  # If this was recieved by the user, we need the info who sent it to them.
end
