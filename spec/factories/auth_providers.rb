FactoryGirl.define do
  factory :auth_provider do
    user_id 1
    provider 'MyString'
    uid 'MyString'
    nickname 'MyString'
    token 'MyString'
    secret 'MyString'
    token_expiration '2014-11-29 07:07:40'
    last_used '2014-11-29 07:07:40'
  end
end
