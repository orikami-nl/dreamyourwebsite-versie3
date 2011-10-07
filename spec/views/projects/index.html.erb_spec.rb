require 'spec_helper'

describe "projects/index.html.erb" do
  before(:each) do
    assign(:projects, [
      stub_model(Project,
        :title => "Title",
        :picture => "Picture",
        :description => "MyText",
        :category => "Category"
      ),
      stub_model(Project,
        :title => "Title",
        :picture => "Picture",
        :description => "MyText",
        :category => "Category"
      )
    ])
  end

  it "renders a list of projects" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Picture".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Category".to_s, :count => 2
  end
end
