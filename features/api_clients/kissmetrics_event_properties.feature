Feature: KISSMetrics event properties 
To be able to track extra information in KISSMetrics events
As a visitor
I want to be able to pass event properties

Scenario: Original landing page
  When I go to the blog page
  Then I should see "ORIGINAL"
  And KISSmetrics receives an event with the following properties:
    | property     | value             |
    | email        | alamont@gmail.com |