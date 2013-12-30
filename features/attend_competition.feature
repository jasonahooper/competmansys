Feature: Attend a competition

  Scenario: A user attends a competition

    Given that I have a "Competition owner" account
    And I am signed in
    And there is a competition named "Test Competition"
    And I am on the competitions page
    Then I will not see "Withdraw"
    And I will see "Attendees: 0"
    When I follow "Attend"
    Then I will see "Attendance recorded successfully."
    And I will see "Withdraw"
    And I will see "Competition attendees: 1"
    When I follow "Withdraw"
    Then I will see "Non-attendance recorded successfully."
    And I will see "Attendees: 0"