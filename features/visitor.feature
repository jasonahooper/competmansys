Feature: Visitor feature

  Scenario: A visitor views a competition

    Given that I am on the home page
    And there is a competition named "Test Competition"
    When I follow "Competitions"
    Then I will see the "List Competitions" page
    When I follow "Info"
    Then I will see "Competition information for Test Competition"
    And I will see "Competition attendees: 0"

  Scenario: A visitor finds a competition by name

    Given that I am on the home page
    And there is a competition named "Test Competition"
    And there is a competition named "Other Competition"
    When I follow "Find"
    Then I will see the "Find Competitions" page
    When I fill in field "keywords" with "other comp"
    And I click "keyword-search"
    Then I will see "Other Competition"
    And I will not see "Test Competition"

  Scenario: A visitor finds a competition by start date

    Given that I am on the home page
    And there is a competition named "First" starting in "1" weeks from now
    And there is a competition named "Second" starting in "2" weeks from now
    When I follow "Find"
    Then I will see the "Find Competitions" page
    When I fill in field "start_date" with "1" weeks from now
    And I click "date-search"
    Then I will see "Second"
    And I will not see "First"

  Scenario: A visitor finds a competition by start and end date

    Given that I am on the home page
    And there is a competition named "First" starting in "1" weeks from now
    And there is a competition named "Second" starting in "2" weeks from now
    When I follow "Find"
    Then I will see the "Find Competitions" page
    When I fill in field "start_date" with "0" weeks from now
    And I fill in field "end_date" with "1" weeks from now
    And I click "date-search"
    Then I will see "First"
    And I will not see "Second"

  Scenario: A visitor finds a competition by location

    Given that I am on the home page
    And there is a competition named "First" located at "0" "0" latlong
    And there is a competition named "Second" located at "1" "1" latlong
    When I follow "Find"
    Then I will see the "Find Competitions" page
    When I fill in field "distance" with "50"
    And I click "location-search"
    Then I will see "First"
    And I will not see "Second"

