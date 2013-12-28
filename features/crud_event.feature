Feature: CRUD Events for a competition

  Background:
    Given that I have a "Competition owner" account
    And I am signed in

  Scenario: A competition owner deletes an event

    Given there is a competition "Test Competition" with event "Test Event"
    And I am on the events page for competition "Test Competition"
    When I follow "Delete"
    Then I will see "Event destroyed successfully."
    And I will not see "Test Event"

  Scenario: A competition owner creates an event

    Given there is a competition named "Test Competition"
    And I am on the competitions page
    When I follow "Events"
    Then I will see "Events for Test Competition"
    When I follow "Add a new event"
    Then I will see "Create Event for Competition Test Competition"
    When I fill in field "event_name" with "Test Event"
    And I click "Create"
    Then I will see "Event created successfully."
    And I will see "Test Event"

  Scenario: A competition owner edits an event

    Given there is an event for "Test Competition" named "Test Event"
    And I am on the events page for "Test Competition"
    When I follow "Edit"
    Then I will see "Edit Event for Competition Test Competition"
    When I fill in field "event_name" with "Test Event Edited"
    And I click "Save"
    Then I will see "Test Event Edited"
    And I will see "Event updated successfully."