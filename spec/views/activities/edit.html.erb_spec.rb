require 'rails_helper'

RSpec.describe 'activities/edit', type: :view do
  before :each do
    @sender = FactoryGirl.create :user
    @recipient = FactoryGirl.create :user

    @message = Message.create!(
      sender: @sender,
      recipient: @recipient,
      verb: 'hug'
    )

    @activity = @message.sender_activity
  end

  it 'renders the edit activity form' do
    render

    assert_select 'form[action=?][method=?]', activity_path(@activity), 'post' do

      assert_select 'input#activity_user_id[name=?]', 'activity[user_id]'

      assert_select 'input#activity_message_id[name=?]', 'activity[message_id]'

      assert_select 'textarea#activity_type[name=?]', 'activity[type]'
    end
  end
end
