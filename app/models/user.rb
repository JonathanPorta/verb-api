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

  def self.find_by_access_token(token)
    # TODO: Fix this when verb authprovider gets implemented
    auth_provider = AuthProvider.where(provider: 'facebook', token: token).first
    auth_provider.user if auth_provider
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
    facebook_auth_provider = AuthProvider.where(provider: 'facebook', uid: user_hash['id']).first
    facebook_auth_provider.user if facebook_auth_provider
  end

  def facebook_connections
    facebook_auth_provider = auth_providers.where(provider: 'facebook').first
    graph = Koala::Facebook::API.new(facebook_auth_provider.token)
    friends = graph.get_connections('me', 'friends')

    user_friends = []
    friends.each do |friend|
      facebook_friend = User.from_facebook(friend)
      user_friends.push(facebook_friend) if facebook_friend
    end
    user_friends
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

  def self.are_friends(user1, user2)
    user1.all_friends.include? user2
  end
end
