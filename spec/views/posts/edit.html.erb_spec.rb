require 'spec_helper'

describe "posts/edit.html.erb" do
  before(:each) do
    @post = assign(:post, stub_model(Post,
      :partner_id => 1,
      :excerpt => "MyText",
      :body => "MyText"
    ))
  end

  it "renders the edit post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => posts_path(@post), :method => "post" do
      assert_select "input#post_partner_id", :name => "post[partner_id]"
      assert_select "textarea#post_excerpt", :name => "post[excerpt]"
      assert_select "textarea#post_body", :name => "post[body]"
    end
  end
end
