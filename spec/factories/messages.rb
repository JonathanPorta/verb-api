# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    sender_id 1
    recipient_id 2
    acknowledged_at '2014-08-17 21:36:27'
    verb 'hug'
  end
end
