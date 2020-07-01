Feature: Signup and edit profile

Scenario: Sign up takes user to profile editor
  Given I am signed out
  When I visit the sign up page
  And I fill in my email address and a password
  And I submit the form
  Then I should be on the first page of the profile editor
  And my account should have been created on the backend
  
Scenario: Complete profile editing
  Given I am signed out
  When I visit the sign up page
  And I fill in my email address and a password
  And I submit the form
  And I fill in my personal name details
  And I go to the next stage
  And I fill in my formal name details
  And I go to the next stage
  And I fill in my pronunciation
  And I go to the next stage
  And I select my pronouns as she/her
  And I go to the next stage
  And I click to finish
  Then I should be on the dashboard
  And my profile should be completed successfully

Scenario: My slug is already taken
  Given I am signed out
  And an Audrey Horne profile already exists
  When I visit the sign up page
  And I fill in my email address and a password
  And I submit the form
  And I fill in my personal name details
  And I go to the next stage
  And I fill in my formal name details
  And I go to the next stage
  And I fill in my pronunciation
  And I go to the next stage
  And I select my pronouns as she/her
  And I go to the next stage
  And I fill in audrey-horne as a slug
  And I click to finish
  Then I should still be on the slug-editing page
  And I should see a message telling me there was a conflict
  And I should see a suggested alternative name prefilled
  
Scenario: Save and exit early
  Given I am signed out
  When I visit the sign up page
  And I fill in my email address and a password
  And I submit the form
  And I fill in my personal name details
  And I go to the next stage
  And I fill in my formal name details
  And I click to save and exit
  Then I should be on the dashboard
  And my profile should be partially completed
  
Scenario: Go back to editor at specified stage
  Given I am signed in as a user with a complete profile
  When I visit the dashboard
  And I click the edit button in the pronouns box
  Then I should be on the pronouns page of the profile editor
