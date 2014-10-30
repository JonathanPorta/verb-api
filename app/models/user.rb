class User < ActiveRecord::Base
  has_many :devices
  has_many :activities
  has_many :messages, through: :activities

  validates :email, :first_name, :last_name, presence: true
  validates :id, absence: true, on: :create

  after_save do
    Librato.measure 'users.count', User.count, sporadic: true
  end

  def self.from_omniauth(auth)
    authed_user = where(facebook_id: auth.uid).first_or_initialize.tap do |user|
      user.facebook_id = auth.uid
      user.facebook_token = auth.credentials.token
      user.facebook_token_expires_at = Time.at(auth.credentials.expires_at) if auth.credentials.expires_at

      user.email = auth.info.email
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.birthday = auth.extra.raw_info.birthday

      user.save!

      Librato.increment 'users.signup'
    end

    # Ensure auth token is up to date.
    if authed_user.facebook_token != auth.credentials.token
      authed_user.facebook_token = auth.credentials.token
      authed_user.save!
    end

    authed_user
  end

  def self.from_facebook(user_hash)
    where(facebook_id: user_hash['id']).first
  end

  def friends
    graph = Koala::Facebook::API.new(:facebook_token)
    friends = graph.get_connections('me', 'friends')

    friends.inject([]) do |app_friends, friend|
      facebook_friend = User.from_facebook(friend)
      app_friends.push(facebook_friend) if facebook_friend
      app_friends
    end
  end
end
