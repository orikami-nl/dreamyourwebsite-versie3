Given /^the following (.+) records?$/ do |factory, table|
  # table is a Cucumber::Ast::Table
	table.hashes.each do |hash|  
	  Factory(factory, hash)  
	end
end

When /^I post a comment "([^"]*)"$/ do |comment|
	fill_in "comment_body", :with => comment
	fill_in "comment_name", :with => "Hassan"
	fill_in "comment_email", :with => "hassan@jassan.nl"
end

