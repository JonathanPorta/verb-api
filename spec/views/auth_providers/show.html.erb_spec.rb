require 'rails_helper'

RSpec.describe 'auth_providers/show', type: :view do
  before(:each) do
    @auth_provider = assign(:auth_provider, AuthProvider.create!(
      user_id: 1,
      provider: 'Provider',
      uid: 'Uid',
      nickname: 'Nickname',
      token: 'Token',
      secret: 'Secret'
    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Provider/)
    expect(rendered).to match(/Uid/)
    expect(rendered).to match(/Nickname/)
    expect(rendered).to match(/Token/)
    expect(rendered).to match(/Secret/)
  end
end
