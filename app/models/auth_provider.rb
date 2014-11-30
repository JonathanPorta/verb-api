class AuthProvider < ActiveRecord::Base
  belongs_to :user

  def self.from_omniauth(auth)
    provider = where(uid: auth.uid, provider: auth.provider).first_or_initialize.tap do |auth_provider|
      auth_provider.provider = auth.provider
      auth_provider.uid = auth.uid

      auth_provider.token = auth.credentials.token
      auth_provider.secret = auth.credentials.secret if auth.credentials.secret
      auth_provider.token_expiration = Time.at(auth.credentials.expires_at) if auth.credentials.expires_at

      auth_provider.nickname = auth.info.nickname if auth.info.nickname
      auth_provider.last_used = Time.now

      auth_provider.save!
    end

    # Ensure auth token is up to date.
    if provider.token != auth.credentials.token
      logger.warn 'Updating user token'
      provider.update token: auth.credentials.token
    end

    provider
  end
end
