json.array!(@friends) do |user|
  user = UserDecorator.new user
  json.extract! user, :id, :name, :first_name, :last_name, :email
  json.is_friend User.are_friends current_user, user
end
