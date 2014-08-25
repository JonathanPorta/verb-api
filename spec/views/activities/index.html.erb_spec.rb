require 'rails_helper'

RSpec.describe "activities/index", :type => :view do
  before(:each) do
    assign(:activities, [
      Activity.create!(
        :user_id => 1,
        :message_id => 2,
        :body => "MyText"
      ),
      Activity.create!(
        :user_id => 1,
        :message_id => 2,
        :body => "MyText"
      )
    ])
  end

  it "renders a list of activities" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
