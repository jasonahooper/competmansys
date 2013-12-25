Feature: Create an event for a competition

  Scenario: A competition owner creates an event

    Given that I have a "Competition owner" account
    And I am signed in
    And there is a competition named "Test Competition"
    And I am on the competitions page
    When I follow "Events"
    Then I will see "Events for Test Competition"
    When I follow "Add a new event"
    Then I will see "Create Event for Competition Test Competition"
    When I fill in field "event_name" with "Test Event"
    And I click "Create"
    Then I will see "Event created successfully."