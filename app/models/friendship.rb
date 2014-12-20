include ActiveModel::Validations

class FriendshipValidator < ActiveModel::Validator
  def validate(record)
    relationships = Friendship.any_friendships record.user, record.friend
    record.errors.add(:base, 'You are already friends, or there is a pending friend request between you.') if relationships.count > 0
  end
end

class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  has_many :activities, as: :actionable, dependent: :destroy

  after_create :create_activity_entries

  validates_with FriendshipValidator, on: :create
  validate :user_cannot_friend_themselves

  def user_cannot_friend_themselves
    errors.add(:friend_id, 'cannot be same as user - stop trying to friend yourself.') if user_id == friend_id
  end

  def accept
    update approved: Time.now
  end

  def self.any_friendships(user, friend)
    # Get any and all friendships linking two users.
    Friendship.where(user: user, friend: friend) + Friendship.where(user: friend, friend: user)
  end

  private

  def create_activity_entries
    Activity.activities_for_friendship self
  end
end
