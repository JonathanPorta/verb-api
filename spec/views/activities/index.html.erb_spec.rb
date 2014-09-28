require 'rails_helper'

RSpec.describe 'activities/index', type: :view do
  before(:each) do
    @user = User.create!(
      first_name: 'Tester',
      last_name: 'Man'
    )

    @message = Message.create!(
      sender: @user,
      recipient_id: 2,
      body: 'MyText'
    )

    @activities = @message.activities

  end

  it 'renders a list of activities' do
    render
    assert_select 'tr>td', text: 'sent'.to_s, count: 1
  end
end
