if @user
  json.(@user,
    :id,
    :first_name,
    :last_name,
    :birthday
  )
else
  json.error 'Not authed. Goto /auth/facebook'
  json.todo 'TODO: raise a proper 401 :-)'
end
