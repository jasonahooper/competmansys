Feature: Registration Feature

  Scenario: A new user registers

    Given that I am on the home page
    When I follow "Register"
    Then I will see the "Sign up" page
    When I fill in field "Email" with "jason@example.com"
    And I fill in field "Password" with "password"
    And I fill in field "Password confirmation" with "password"
    And I fill in field "First name" with "Self"
    And I fill in field "Last name" with "Iam"
    And I click "Sign up"
    Then I will see "Welcome! You have signed up successfully."