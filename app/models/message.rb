class Message < ActiveRecord::Base
  def self.sent_to(user)
    where recipient_id: user.id
  end

  def self.sent_by(user)
    where sender_id: user.id
  end
end
