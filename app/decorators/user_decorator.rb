class UserDecorator < Draper::Decorator
  delegate :id, :first_name, :last_name, :email

  def name
    "#{ first_name } #{ last_name }"
  end
end
