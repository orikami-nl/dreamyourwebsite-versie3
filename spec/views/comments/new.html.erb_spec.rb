require 'spec_helper'

describe "comments/new.html.erb" do
  before(:each) do
    assign(:comment, stub_model(Comment,
      :body => "MyText",
      :name => "MyString",
      :email => "MyString",
      :post_id => 1
    ).as_new_record)
  end

  it "renders new comment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => comments_path, :method => "post" do
      assert_select "textarea#comment_body", :name => "comment[body]"
      assert_select "input#comment_name", :name => "comment[name]"
      assert_select "input#comment_email", :name => "comment[email]"
      assert_select "input#comment_post_id", :name => "comment[post_id]"
    end
  end
end
