Feature: Sign in

Scenario: Sign into existing account
  Given I am signed out
  And I have previously created a user
  When I visit the root path
  And I click to log in
  And I fill in my email address
  And I fill in my password
  And I submit the form
  Then I should see a message telling me I have signed in
  And I should see a link to edit my account

@javascript
Scenario: Sign out
  Given I am signed in
  When I visit the root path
  And I click to sign out
  Then I should see a message telling me I have signed out
  And I should not see a link to edit my account

@javascript
Scenario: Close message (JavaScript sanity test)
  Given I am signed out
  And I have previously created a user
  When I visit the root path
  And I click to log in
  And I fill in my email address
  And I fill in my password
  And I submit the form
  And I click to close the message
  Then I should not see a message telling me I have signed in
