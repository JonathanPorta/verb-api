class Activity < ActiveRecord::Base

  self.inheritance_column = :_type_disabled

  belongs_to :message

  def self.activities_for_message(message)
    # Sender activity
    Activity.create user_id: message.sender_id, message_id: message.id, type: 'sent'
    # Recipient activity
    Activity.create user_id: message.recipient_id, message_id: message.id, type: 'received'
  end
end
