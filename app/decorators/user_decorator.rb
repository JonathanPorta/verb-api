class UserDecorator < Draper::Decorator
  delegate :id, :first_name, :last_name, :email

  def relationship(friend)
    relationship = Friendship.any_friendships object, friend

    # This should never return more than 1 friendship.
    # If this returns more than one friendship, then our data validation is wrong.
    # In fact, it is likely that our entire understanding of everthing is wrong.
    fail 'Invalid Friendship Data' if relationship.count > 1

    if relationship.count == 0
      return 'not friends'
    elsif relationship.first.approved
      return 'friends'
    else
      if relationship.first.user == object
        # User sent friend a request, but friend didn't accept yet.
        # Friendship status are phrased from the perspective of the user.
        # Therefore, this status would be 'friendship request sent'.
        return 'friendship requested'
      else
        # relationship.first.friend == object
        # Request was sent to user, by friend.
        return 'friendship received'
      end
    end
  end

  def name
    "#{ first_name } #{ last_name }"
  end
end
