class User < ActiveRecord::Base
  has_many :devices
  has_many :activities
  has_many :messages, through: :activities

  has_many :friendships
  has_many :friends, -> { where.not(friendships: { approved: nil }) }, through: :friendships

  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_friends, -> { where.not(friendships: { approved: nil }) }, through: :inverse_friendships, source: :user

  has_many :auth_providers

  validates :email, :first_name, :last_name, presence: true
  validates :id, absence: true, on: :create

  after_save do
    Librato.measure 'users.count', User.count, sporadic: true
  end

  def self.from_omniauth(auth)
    auth_provider = AuthProvider.from_omniauth auth

    if auth_provider.user
      user = auth_provider.user
    else
      user = User.new
    end

    user.email = auth.info.email
    user.first_name = auth.info.first_name
    user.last_name = auth.info.last_name
    user.birthday = auth.extra.raw_info.birthday

    user.save!
    auth_provider.update user: user
    user
  end

  def self.from_facebook(user_hash)
    where(facebook_id: user_hash['id']).first
  end

  def all_friends
    friends + inverse_friends
  end

  def friendship_requests_sent
    friendships.where approved: nil
  end

  def friendship_requests_received
    inverse_friendships.where approved: nil
  end
end
