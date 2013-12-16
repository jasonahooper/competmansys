Feature: Become a competition owner

  Scenario: A user wishes to create competitions

    Given that I have a normal user account
    And I am signed in
    When I follow "Edit registration"
    Then I will see the "Edit User" page
    When I check "Competition owner"
    And fill in my current password
    And I click "Update"
    Then I will see "You updated your account successfully."
    When I follow "Edit registration"
    Then I will see "#user_roles_competition_owner" checked