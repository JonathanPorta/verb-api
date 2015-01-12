user = @user.decorate
json.extract! user, :id, :email, :first_name, :last_name
