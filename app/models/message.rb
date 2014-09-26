class Message < ActiveRecord::Base

  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  has_many :activities, dependent: :destroy
  has_one :sender_activity, ->(message) { where type: 'sent', message_id: message.id }, class_name: 'Activity'
  has_one :recipient_activity, ->(message) { where type: 'received', message_id: message.id }, class_name: 'Activity'

  after_create :create_activity_entries

  def self.sent_by(user)
    where sender: user
  end

  def self.sent_to(user)
    where recipient: user
  end

  private
    def create_activity_entries
      # TODO Create activities for each user.
      Activity.activities_for_message(self)
    end
end
