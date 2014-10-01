require 'rails_helper'

RSpec.describe 'activities/show', type: :view do
  before(:each) do

    @sender = User.create!(
      first_name: 'Sender',
      last_name: 'Man',
      email: 'sender@senderman.tested'
    )

    @recipient = User.create!(
      first_name: 'Reciever',
      last_name: 'Man',
      email: 'receiver@receiverman.tested'
    )

    @message = Message.create!(
      sender: @sender,
      recipient: @recipient,
      verb: 'hug'
    )

    @activity = @message.sender_activity

  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Sender Man/)
    expect(rendered).to match(/hug/)
    expect(rendered).to match(/sent/)
  end
end
