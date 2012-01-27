Feature: blog
	In order to read the blog and post comments
	As a visitor
	I want to be able to interact with the blog page

	Background:
	Given I have 10 post records by "Pietje Puk"

	@wip
	Scenario: Visitor goes to next blog page
		When I go to the blog page
		Then show me the page
		And I should see "Post1"

	Scenario: Visitor writes a comment
		When I go to the blog page
		And I follow "Post1"
		And I post a comment "Goed Man"
		And I press "Plaats Bericht"
		Then I should see "Goed Man"
