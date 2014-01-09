Feature: Find JustGiving ID

@javascript
  Scenario: A competition owner finds and selects a justGiving ID

    Given that I have a "Competition owner" account
    And I am signed in
    And there is a competition named "Test Competition"
    And I am on the competitions page
    When I follow "Edit"
    Then I will see "Edit Competition Test Competition"
    And field "competition_justgiving_id" will be empty
    When I click "find"
    Then I will see "Find JustGiving Id"
    When I fill in field "justgiving-search-text" with "efds"
    And I click "Find"
    Then I will see "English Federation of Disability Sport : 59992"
    When I click on "English Federation of Disability Sport : 59992" in ".search-results"
    Then I will not see "English Federation of Disability Sport : 59992"
    And field "competition_justgiving_id" will contain "59992"