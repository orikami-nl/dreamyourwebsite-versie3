Feature: blog
	In order to read the blog and post comments
	As a visitor
	I want to be able to interact with the blog page

	Background:
		Given the following partner records
		| name       | id |
		| Pietje Puk | 1  |
		Given the following post records
		| title				      | partner_id |
		| Eerste post				| 1					 |
		| Tweede post				| 1					 |
		| Derde post				| 1					 |
		| Vierde post				| 1					 |
		| Vijfde post				| 1					 |
		| Zesde post				| 1					 |
		| Zevende post			| 1					 |
		| Achtste post			| 1					 |
		| Negende post			| 1					 |
		| Tiende post				| 1					 |

	Scenario: User goes to next blog page
		When I go to the blog page
		Then show me the page
		And I should see "Eerste post"
