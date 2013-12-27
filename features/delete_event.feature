Feature: Delete an event for a competition

  Scenario: A competition owner deletes an event

    Given that I have a "Competition owner" account
    And I am signed in
    And there is a competition "Test Competition" with event "Test Event"
    And I am on the events page for competition "Test Competition"
    When I follow "Delete"
    Then I will see "Event destroyed successfully."
    And I will not see "Test Event"