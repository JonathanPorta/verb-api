require 'rails_helper'

RSpec.describe 'messages/edit', type: :view do
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

  it 'renders the edit message form' do
    render

    assert_select 'form[action=?][method=?]', message_path(@message), 'post' do
      assert_select 'input#message_recipient_id[name=?]', 'message[recipient_id]'
      assert_select 'textarea#message_verb[name=?]', 'message[verb]'
    end
  end
end
