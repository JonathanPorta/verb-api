class User < ActiveRecord::Base
  def self.from_omniauth(auth)
    where(facebook_id: auth.uid ).first_or_initialize.tap do |user|
      user.facebook_id = auth.uid
      user.facebook_token = auth.credentials.token
      user.facebook_token_expires_at = Time.at(auth.credentials.expires_at)

      user.email = auth.info.email
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.birthday = auth.extra.raw_info.birthday
      
      user.save!
    end
  end
end