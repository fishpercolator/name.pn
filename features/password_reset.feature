Feature: Password reset

Scenario: Reset a forgotten password
  Given I am signed out
  And I have previously created a user
  When I visit the sign in page
  And I click the link for a lost password
  And I ask for reset instructions for my email address
  Then I should see a message saying the instructions are on their way
  When I follow the link in the email I was sent
  And I choose a new password
  Then I should see a message telling me my password has changed
  And I should be able to use my new password
