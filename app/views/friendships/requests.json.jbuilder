# requests sent to the user to be a friend
json.array!(@friendships) do |friendship|
  json.extract! friendship, :id, :approved
  json.sender do
    sender = UserDecorator.new friendship.user
    json.extract! sender, :id, :name, :first_name, :last_name, :email
  end
end
