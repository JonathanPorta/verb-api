class Device < ActiveRecord::Base
  belongs_to :user

  validates :user, :token, presence: true

  def notify(message)
    logger.info "Sending Notification of #{ message }to device: #{ self.token }"
    APNS.send_notification self.token, message
  end
end
