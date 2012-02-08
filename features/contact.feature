Feature: Contact
	In order to come in contact with dreamyourweb
	As a visitor
	I want to be able to send an email via the contact form

	Scenario: Send contact
		Given I am on the contact page
		And no emails have been sent
		When I fill in the subject
		And I fill in the message
		And I fill in my contact details
		And I press "Verzenden"
		Then "info@dreamyourweb.nl" should receive an email
		And KISSmetrics receives an event with the following properties:
    		| property     | value             	  |
    		| email        | info@dreamyourweb.nl |

	Scenario: Do not send contact without contact details
		Given I am on the contact page
		And no emails have been sent
		When I fill in the subject
		And I fill in the message
		And I press "Verzenden"
		Then I should see "Uw bericht kan niet verzonden worden om de volgende reden"
		
