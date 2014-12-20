json.array!(@friends) do |friend|
  friend = UserDecorator.new friend
  user = UserDecorator.new current_user

  json.extract! friend, :id, :name, :first_name, :last_name, :email
  json.relationship user.relationship(friend)
end
