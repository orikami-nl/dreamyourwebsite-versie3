Feature: blog
	In order to read the blog and post comments
	As a visitor
	I want to be able to interact with the blog page

	Background:
		Given the following partner records
		| name       |
		| Pietje Puk |
		Given the following post records
		| title				      |
		| Eerste post				|
		| Tweede post				|
		| Derde post				|
		| Vierde post				|
		| Vijfde post				|
		| Zesde post				|
		| Zevende post			|
		| Achtste post			|
		| Negende post			|
		| Tiende post				|

	Scenario: Visitor goes to next blog page
		When I go to the blog page
		Then show me the page
		And I should see "Eerste post"

	Scenario: Visitor writes a comment
		When I go to the eerste post page
		And I fill in "comment_body" with "Mijn commentaar"
		And I fill in "comment_name" with "Hassan"
		And I fill in "comment_email" with "hassan@jassan.nl"
