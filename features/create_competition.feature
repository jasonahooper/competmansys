Feature: Create a competition

  Scenario: A user creates a competition

    Given that I have a "Competition owner" account
    And I am signed in
    When I follow "Create"
    Then I will see the "Create Competition" page
