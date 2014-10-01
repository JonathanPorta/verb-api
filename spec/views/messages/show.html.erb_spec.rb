require 'rails_helper'

RSpec.describe 'messages/show', type: :view do
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
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to include(@sender.id.to_s)
    expect(rendered).to include(@recipient.id.to_s)
    expect(rendered).to include(@message.verb)
  end
end
