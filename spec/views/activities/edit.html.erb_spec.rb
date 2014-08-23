require 'rails_helper'

RSpec.describe "activities/edit", :type => :view do
  before(:each) do
    @activity = assign(:activity, Activity.create!(
      :user_id => 1,
      :message_id => 1,
      :body => "MyText"
    ))
  end

  it "renders the edit activity form" do
    render

    assert_select "form[action=?][method=?]", activity_path(@activity), "post" do

      assert_select "input#activity_user_id[name=?]", "activity[user_id]"

      assert_select "input#activity_message_id[name=?]", "activity[message_id]"

      assert_select "textarea#activity_body[name=?]", "activity[body]"
    end
  end
end
