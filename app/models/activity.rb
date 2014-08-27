class Activity < ActiveRecord::Base

  def self.activities_for_message(message)
    # Sender activity
    Activity.create user_id: message.sender_id, message_id: message.id, body: "You sent: #{ message.body }"
    # Recipient activity
    Activity.create user_id: message.recipient_id, message_id: message.id, body: "You received: #{ message.body }"
  end
end
