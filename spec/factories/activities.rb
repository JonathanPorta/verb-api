# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    user_id 1
    message_id 1
    acknowledged_at "2014-08-23 15:19:40"
    body "MyText"
  end
end
