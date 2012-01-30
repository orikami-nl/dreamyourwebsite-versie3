Feature: partner
	In order to keep actual partners up to date
	As a partner
	I want to be able to toggle partner activation

	Scenario: toggle partner off
		Given I am logged in as an admin
		And a partner named "Karel Hobbema"
		When I go to the about page
		And I follow "Edit"
		And I uncheck the active partner checkbox
		And I press "Submit"
		And I follow "Logout"
		And I go to the about page
		Then I should not see "Karel Hobbema"
