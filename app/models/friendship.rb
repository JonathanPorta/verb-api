class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  has_many :activities, as: :actionable, dependent: :destroy

  after_create :create_activity_entries

  def accept
    update approved: Time.now
  end

  private

  def create_activity_entries
    Activity.activities_for_friendship self
  end
end
