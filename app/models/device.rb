class Device < ActiveRecord::Base
  belongs_to :user

  validates :user, :token, presence: true

  def notify
    APNS.send_notification :token.to_s, 'Hello from Rails app!'
  end
end
