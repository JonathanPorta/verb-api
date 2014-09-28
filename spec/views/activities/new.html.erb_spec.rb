require 'rails_helper'

RSpec.describe "activities/new", type: :view do
  before(:each) do
    assign(:activity, Activity.new(
      user_id: 1,
      message_id: 1,
      type: "MyText"
    ))
  end

  it "renders new activity form" do
    render

    assert_select "form[action=?][method=?]", activities_path, "post" do

      assert_select "input#activity_user_id[name=?]", "activity[user_id]"

      assert_select "input#activity_message_id[name=?]", "activity[message_id]"

      assert_select "textarea#activity_type[name=?]", "activity[type]"
    end
  end
end
