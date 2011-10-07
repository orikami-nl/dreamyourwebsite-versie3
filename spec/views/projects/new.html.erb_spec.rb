require 'spec_helper'

describe "projects/new.html.erb" do
  before(:each) do
    assign(:project, stub_model(Project,
      :title => "MyString",
      :picture => "MyString",
      :description => "MyText",
      :category => "MyString"
    ).as_new_record)
  end

  it "renders new project form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => projects_path, :method => "post" do
      assert_select "input#project_title", :name => "project[title]"
      assert_select "input#project_picture", :name => "project[picture]"
      assert_select "textarea#project_description", :name => "project[description]"
      assert_select "input#project_category", :name => "project[category]"
    end
  end
end
