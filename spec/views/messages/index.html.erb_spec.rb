require 'rails_helper'

RSpec.describe 'messages/index', type: :view do
  before(:each) do
    assign(:messages, [
      Message.create!(
        sender_id: 1,
        recipient_id: 2,
        verb: 'hug'
      ),
      Message.create!(
        sender_id: 1,
        recipient_id: 2,
        verb: 'hug'
      )
    ])
  end

  # it 'renders a list of messages' do
  #   render
  #   assert_select 'tr>td', text: 1.to_s, count: 2
  #   assert_select 'tr>td', text: 2.to_s, count: 2
  #   assert_select 'tr>td', text: 'hug'.to_s, count: 2
  # end
end
