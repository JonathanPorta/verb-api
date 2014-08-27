class Message < ActiveRecord::Base

  after_create :create_activity_entries

  def self.sent_to(user)
    where recipient_id: user.id
  end

  def self.sent_by(user)
    where sender_id: user.id
  end

  private
    def create_activity_entries
      # TODO Create activities for each user.
      Activity.activities_for_message(self)
    end
end
