class Message < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  has_many :activities, dependent: :destroy
  has_one :sender_activity, ->(message) { where type: 'sent', message_id: message.id }, class_name: 'Activity'
  has_one :recipient_activity, ->(message) { where type: 'received', message_id: message.id }, class_name: 'Activity'

  after_create :create_activity_entries

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
  end

  def self.reciprocate(original_message)
    Message.create sender: original_message.recipient, recipient: original_message.sender, verb: original_message.verb
  end

  private

  def create_activity_entries
    Activity.activities_for_message(self)
  end
end
