require 'rails_helper'

RSpec.describe 'auth_providers/index', type: :view do
  before(:each) do
    assign(:auth_providers, [
      AuthProvider.create!(
        user_id: 1,
        provider: 'Provider',
        uid: 'Uid',
        nickname: 'Nickname',
        token: 'Token',
        secret: 'Secret'
      ),
      AuthProvider.create!(
        user_id: 1,
        provider: 'Provider',
        uid: 'Uid',
        nickname: 'Nickname',
        token: 'Token',
        secret: 'Secret'
      )
    ])
  end

  it 'renders a list of auth_providers' do
    render
    assert_select 'tr>td', text: 1.to_s, count: 2
    assert_select 'tr>td', text: 'Provider'.to_s, count: 2
    assert_select 'tr>td', text: 'Uid'.to_s, count: 2
    assert_select 'tr>td', text: 'Nickname'.to_s, count: 2
    assert_select 'tr>td', text: 'Token'.to_s, count: 2
    assert_select 'tr>td', text: 'Secret'.to_s, count: 2
  end
end
