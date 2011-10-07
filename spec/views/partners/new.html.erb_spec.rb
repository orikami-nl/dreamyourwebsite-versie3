require 'spec_helper'

describe "partners/new.html.erb" do
  before(:each) do
    assign(:partner, stub_model(Partner,
      :name => "MyString",
      :avatar => "MyString",
      :biography => "MyText",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new partner form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => partners_path, :method => "post" do
      assert_select "input#partner_name", :name => "partner[name]"
      assert_select "input#partner_avatar", :name => "partner[avatar]"
      assert_select "textarea#partner_biography", :name => "partner[biography]"
      assert_select "textarea#partner_description", :name => "partner[description]"
    end
  end
end
