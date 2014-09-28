# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  sequence :facebook_id do |number|
    number
  end

  factory :user do
    facebook_id
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    birthday { Faker::Business.credit_card_expiry_date }
    facebook_token ''
    facebook_token_expires_at { 1.year.from_now }
  end
end
