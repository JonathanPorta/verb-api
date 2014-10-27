json.array!(@friends) do |user|
  user = UserDecorator.new user
  json.extract! user, :id, :name, :first_name, :last_name, :email
end
