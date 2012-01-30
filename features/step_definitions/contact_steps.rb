When /^I fill in the subject$/ do
  fill_in "contact_form_subject", :with => "Onderwerp"
end

When /^I fill in the message$/ do
  fill_in "contact_form_message", :with => "Bericht"
end

When /^I fill in my contact details$/ do
  fill_in "contact_form_info", :with => "Onderwerp"
end
