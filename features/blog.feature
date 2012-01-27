Feature: blog
	In order to read the blog and post comments
	As a visitor
	I want to be able to interact with the blog page

	Background:
	Given I have 9 post records by "Pietje Puk"

	Scenario: Visitor goes to next blog page
		When I go to the blog page
		And I follow "Next"
		Then I should see "Post1"
		And I should not see "Post9"

	Scenario: Visitor writes a comment
		When I go to the blog page
		And I follow "Post9"
		And I post a comment "Goed Man"
		And I press "Plaats Bericht"
		Then I should see "Goed Man"
