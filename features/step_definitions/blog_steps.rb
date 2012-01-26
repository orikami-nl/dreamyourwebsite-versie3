Given /^the following partner records$/ do |table|
  # table is a Cucumber::Ast::Table
	table.hashes.each do |hash|  
	  Factory(:partner, hash)  
	end
end

Given /^the following post records$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |hash|  
    Factory(:post, hash)  
  end
end

