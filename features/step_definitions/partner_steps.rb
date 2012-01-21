Given /^I am logged in as an admin$/ do
	Admin.create!(:email => "admin@dreamyourweb.nl", :password => "testing", :password_confirmation => "testing")
	visit login_path
	fill_in "admin_email", :with => "admin@dreamyourweb.nl"
	fill_in "admin_password", :with => "testing"
	click_on "Sign in" 
end

Given /^a partner named "([^"]*)"$/ do |name|
	Factory(:partner, :name => name)
end

When /^I uncheck the active partner checkbox$/ do
	uncheck("partner_active")
end

