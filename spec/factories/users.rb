# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    birthday { Faker::Business.credit_card_expiry_date }
    password 'password'

    factory :user_with_facebook_auth do
      after(:create) do |user|
        create_list(:auth_provider, 1, user: user)
      end
    end
  end
end
