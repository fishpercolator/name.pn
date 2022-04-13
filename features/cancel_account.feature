Feature: Cancel account

@javascript
Scenario: Cancel account
  Given I am signed in as a user with a complete profile
  When I visit the account page
  And I click to cancel my account and confirm the action
  Then my account should be deleted
  And I should be signed out on the home page
  And I should see a message confirming my account has gone
