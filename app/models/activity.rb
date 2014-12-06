class Activity < ActiveRecord::Base
  self.inheritance_column = :_type_disabled

  belongs_to :actionable, polymorphic: true
  belongs_to :user

  validates :user, :actionable, :type, presence: true
  validates :id, absence: true, on: :create
  validates :type, inclusion: { in: %w(sent received) }

  after_save :notify

  def self.activities_for_message(message)
    # Sender activity
    Activity.create user: message.sender, actionable: message, type: 'sent'

    # Recipient activity
    Activity.create user: message.recipient, actionable: message, type: 'received'
  end

  def self.activities_for_friendship(friendship)
    # Sender activity
    Activity.create user: friendship.user, actionable: friendship, type: 'sent'

    # Recipient activity
    Activity.create user: friendship.friend, actionable: friendship, type: 'received'
  end

  private

  def notify
    return if type != 'received'
    message = decorate.activity_message
    logger.info "Preparing to send push notification of #{ message } to recipient: #{ user.id }"

    user.devices.each do |device|
      device.notify message
    end
  end
end
