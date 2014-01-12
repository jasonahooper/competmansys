Feature: Create a competition

  Scenario: A user creates a competition

    Given that I have a "Competition owner" account
    And I am signed in
    When I follow "Create"
    Then I will see the "Create Competition" page
    When I fill in field "competition_name" with "Test Competition"
    And I fill in field "competition_description" with "Test Description"
    And I fill in field "Start date" with date "2.weeks.from_now"
    And I fill in field "End date" with date "3.weeks.from_now"
    And I fill in field "Registration close date" with date "1.week.from_now"
    And I fill in field "Location" with "London, England"
    And I select file "app/assets/images/Sheffield.jpg" for "competition_image"
    And I click "Create"
    Then I will see the "Test Competition" page