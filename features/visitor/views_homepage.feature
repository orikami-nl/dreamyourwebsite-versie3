Feature: Split test
To behave different on different copy
As a visitor
I want to break free

Scenario: Original landing page
  When I go to the home page with the "original" alternative for the "landing_page" experiment
  Then I should see "ORIGINAL"
  And KISSmetrics receives the following properties:
    | property     | value    |
    | landing_page | original |

Scenario: New copy on landing page
  When I go to the home page with the "new_copy" alternative for the "landing_page" experiment
  Then I should see "NOT ORIGINAL"
  And KISSmetrics receives the following properties:
    | property     | value    |
    | landing_page | new_copy |