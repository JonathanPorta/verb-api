require 'rails_helper'

RSpec.describe 'activities/index', type: :view do
  before(:each) do
    @sender = FactoryGirl.create :user
    @recipient = FactoryGirl.create :user

    @message = Message.create!(
      sender: @sender,
      recipient: @recipient,
      verb: 'hug'
    )

    @activities = @message.activities

  end

  it 'renders a list of activities' do
    render
    expect(rendered).to match(/sent/)
  end
end
