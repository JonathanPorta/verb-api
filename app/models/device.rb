class Device < ActiveRecord::Base
  belongs_to :user

  validates :user, :token, presence: true

  after_create do
    Librato.increment 'devices.registered', sporadic: true
  end

  def notify(message)
    logger.info "Sending Notification of #{ message }to device: #{ token }"
    APNS.send_notification token, message
    Librato.increment 'notifications.sent'
  end
end
