Feature: Visitor feature

  Scenario: A visitor views a competition

    Given that I am on the home page
    And there is a competition named "Test Competition"
    When I follow "Competitions"
    Then I will see the "List Competitions" page
    When I follow "Info"
    Then I will see "Competition information for Test Competition"
    And I will see "Competition attendees: 0"

  Scenario: A visitor finds a competition

    Given that I am on the home page
    And there is a competition named "Test Competition"
    And there is a competition named "Other Competition"
    When I follow "Find"
    Then I will see the "Find Competitions" page
    When I fill in field "keywords" with "other comp"
    And I click "keyword-search"
    Then I will see "Other Competition"
    And I will not see "Test Competition"
