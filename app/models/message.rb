class Message < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  has_many :activities, as: :actionable, dependent: :destroy
  has_one :sender_activity, ->(message) { where type: 'sent', actionable_id: message.id, actionable_type: 'Message' }, class_name: 'Activity'
  has_one :recipient_activity, ->(message) { where type: 'received', actionable_id: message.id, actionable_type: 'Message' }, class_name: 'Activity'

  after_create :create_activity_entries
  after_save do
    Librato.increment 'messages.sent'
  end

  # Let's at least try to keep the db nice and tidy.
  validates :sender, :recipient, :verb, presence: true
  validates :id, absence: true, on: :create

  def self.sent_by(user)
    where sender: user
  end

  def self.sent_to(user)
    where recipient: user
  end

  def acknowledge
    update acknowledged_at: Time.now
    notify_acknowledgement
    Librato.increment 'messages.acknowledged'
  end

  def self.reciprocate(original_message)
    new_message = Message.create sender: original_message.recipient, recipient: original_message.sender, verb: original_message.verb
    Librato.increment 'messages.reciprocated'
    new_message
  end

  private

  def create_activity_entries
    Activity.activities_for_message self
  end

  # Notify sender that message was ack'd
  def notify_acknowledgement
    # message = sender_activity.decorate.activity_message
    # logger.info "Preparing to send acknowledgment push notification of #{ message } to sender: #{ sender.id }"
    #
    # sender.devices.each do |device|
    #   device.notify message
    # end
  end
end
