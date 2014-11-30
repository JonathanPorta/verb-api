# sent by the user
json.array!(@friendships) do |friendship|
  json.extract! friendship, :id, :approved
  json.recipient do
    recipient = UserDecorator.new friendship.friend
    json.extract! recipient, :id, :name, :first_name, :last_name, :email
  end
end
