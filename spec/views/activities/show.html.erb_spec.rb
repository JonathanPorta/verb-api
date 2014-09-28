require 'rails_helper'

RSpec.describe 'activities/show', type: :view do
  before(:each) do

    @user = User.create!(
      first_name: 'Tester',
      last_name: 'Man'
    )

    @message = Message.create!(
      sender: @user,
      recipient_id: 2,
      verb: 'hug'
    )

    @activity = @message.sender_activity

  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Tester Man/)
    expect(rendered).to match(/hug/)
    expect(rendered).to match(/sent/)
  end
end
