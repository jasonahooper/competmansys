Feature: Sign-in Feature

  Scenario: A user signs in

    Given that I am on the home page
    And I have a user account with email "user@example.com" and password "password"
    When I follow "Login"
    Then I will see the "Sign in" page
    When I fill in field "Email" with "user@example.com"
    And I fill in field "Password" with "password"
    And I click "Sign in"
    Then I will see "Signed in successfully."
