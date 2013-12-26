Feature: Edit an event for a competition

  Scenario: A competition owner edits an event

    Given that I have a "Competition owner" account
    And I am signed in
    And there is an event for "Test Competition" named "Test Event"
    And I am on the events page for "Test Competition"
    When I follow "Edit"
    Then I will see "Edit Event for Competition Test Competition"
    When I fill in field "event_name" with "Test Event Edited"
    And I click "Save"
    Then I will see "Test Event Edited"
    And I will see "Event updated successfully."