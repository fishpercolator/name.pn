Feature: Edit account

Scenario: Change email address
  Given I am signed in
  When I visit the account page
  And I change my email address
  And I enter my current password
  And I save my account
  Then I should see a message telling me my account has been updated
  And my email address should have changed

Scenario: Change password
  Given I am signed in
  When I visit the account page
  And I choose a new password
  And I enter my current password
  And I save my account
  Then I should see a message telling me my account has been updated
  And my password should have changed

Scenario: Wrong current password
  Given I am signed in
  When I visit the account page
  And I change my email address
  And I enter the wrong current password
  And I save my account
  Then I should see an error saying my current password is invalid
  And my email address should not have changed
