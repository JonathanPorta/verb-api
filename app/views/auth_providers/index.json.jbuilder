json.array!(@auth_providers) do |auth_provider|
  json.extract! auth_provider, :id, :user_id, :provider, :uid, :nickname, :token, :secret, :token_expiration, :last_used
  json.url auth_provider_url(auth_provider, format: :json)
end
