OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FB_APP_ID'], ENV['FB_APP_SECRET'], scope: 'email,user_birthday,user_friends'
  provider :facebook_access_token, ENV['FB_APP_ID'], ENV['FB_APP_SECRET'], scope: 'email,user_birthday,user_friends'
end

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}
