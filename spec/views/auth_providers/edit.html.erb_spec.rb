require 'rails_helper'

RSpec.describe "auth_providers/edit", :type => :view do
  before(:each) do
    @auth_provider = assign(:auth_provider, AuthProvider.create!(
      :user_id => 1,
      :provider => "MyString",
      :uid => "MyString",
      :nickname => "MyString",
      :token => "MyString",
      :secret => "MyString"
    ))
  end

  it "renders the edit auth_provider form" do
    render

    assert_select "form[action=?][method=?]", auth_provider_path(@auth_provider), "post" do

      assert_select "input#auth_provider_user_id[name=?]", "auth_provider[user_id]"

      assert_select "input#auth_provider_provider[name=?]", "auth_provider[provider]"

      assert_select "input#auth_provider_uid[name=?]", "auth_provider[uid]"

      assert_select "input#auth_provider_nickname[name=?]", "auth_provider[nickname]"

      assert_select "input#auth_provider_token[name=?]", "auth_provider[token]"

      assert_select "input#auth_provider_secret[name=?]", "auth_provider[secret]"
    end
  end
end
