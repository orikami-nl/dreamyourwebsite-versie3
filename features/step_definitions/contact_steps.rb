World(EmailHelpers)

Given /^(?:a clear email queue|no emails have been sent)$/ do
  reset_mailer
end

When /^I fill in the subject$/ do
  fill_in "contact_form_subject", :with => "Onderwerp"
end

When /^I fill in the message$/ do
  fill_in "contact_form_message", :with => "Bericht"
end

When /^I fill in my contact details$/ do
  fill_in "contact_form_info", :with => "Onderwerp"
end

Then /^(?:I|they|"([^"]*?)") should receive (an|no|\d+) emails?$/ do |address, amount|
  unread_emails_for(address).size.should == parse_email_count(amount)
end

