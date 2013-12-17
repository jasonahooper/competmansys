Feature: Create a competition

  Scenario: A user creates a competition

    Given that I have a "Competition owner" account
    And I am signed in
    When I follow "Create"
    Then I will see the "Create Competition" page
    When I fill in field "competition_name" with "Test Competition"
    And I fill in field "competition_description" with "Test Description"
    And I fill in field "Start date" with "11/01/2014"
    And I fill in field "End date" with "01/02/2014"
    And I fill in field "Registration close date" with "01/01/2014"
    And I fill in field "Location" with "London, England"
    And I select file "app/assets/images/Sheffield.jpg" for "competition_image"
    And I click "Create"
    Then I will see the "Show Competition:" page