class Activity < ActiveRecord::Base
  self.inheritance_column = :_type_disabled

  belongs_to :message
  belongs_to :user

  validates :user, :message, :type, presence: true
  validates :id, absence: true, on: :create
  validates :type, inclusion: { in: %w(sent received) }

  after_save :notify

  def self.activities_for_message(message)
    # Sender activity
    Activity.create user: message.sender, message: message, type: 'sent'

    # Recipient activity
    Activity.create user: message.recipient, message: message, type: 'received'
  end

  private

  def notify
    return if :type != 'received'
    message = decorate.activity_message
    logger.info "Preparing to send push notification of #{ message } to recipient: #{ user.id }"

    user.devices.each do |device|
      device.notify message
    end
  end
end
