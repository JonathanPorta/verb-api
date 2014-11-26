module FacebookSpecHelper
  def create_test_user
    @test_api = Koala::Facebook::TestUsers.new app_id: ENV['FB_APP_ID'], secret: ENV['FB_APP_SECRET']
    @test_api.delete_all # Clear out any existing users (FB has a limit on number of users)

    # Make a fake user
    user = @test_api.create true, 'email,user_birthday,user_friends'

    # Make some fake friends
    friend = @test_api.create true, 'email,user_birthday,user_friends'
    friend2 = @test_api.create true, 'email,user_birthday,user_friends'
    @test_api.befriend user, friend
    @test_api.befriend user, friend2

    # Get the fake profile data
    user_profile = Koala::Facebook::API.new(user['access_token']).get_objects('me')
    user_profile['access_token'] = user['access_token']

    user_profile
  end

  def omniauth_hash_mock
    OmniAuth::AuthHash.new(
      'provider' => 'facebook',
      'uid' => '123545',
      'info' => {
        'first_name' => 'Testy',
        'last_name' => 'Userdood',
        'email' => 'dpsk@email.ru'
      },
      'credentials' => {
        'token' => 'superfaketoken'
      },
      'extra' => {
        'raw_info' => {
          'birthday' => 'January 1st, 1432'
        }
      }
    )
  end
end
