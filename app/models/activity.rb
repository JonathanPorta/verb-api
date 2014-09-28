class Activity < ActiveRecord::Base
  self.inheritance_column = :_type_disabled

  belongs_to :message
  belongs_to :user

  validates :user, :message, :type, presence: true
  validates :id, absence: true, on: :create
  validates :type, inclusion: { in: %w(sent received) }

  def self.activities_for_message(message)
    # Sender activity
    Activity.create user: message.sender, message: message, type: 'sent'

    # Recipient activity
    Activity.create user: message.recipient, message: message, type: 'received'
  end
end
