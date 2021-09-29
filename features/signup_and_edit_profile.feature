Feature: Signup and edit profile

Scenario: Sign up takes user to profile editor
  Given I am signed out
  When I visit the sign up page
  And I fill in my email address and a password
  And I submit the form
  Then I should be on the first page of the profile editor
  And my account should have been created on the backend

Scenario: Cannot leave first page until it's completed
  Given I am signed in as a user with no profile
  When I try to go the home page
  Then I should be redirected back to the first page of the profile editor
  And I should not see links to the other sections
  And I should not see a save and exit button

Scenario: Can see dashboard if first page has been completed
  Given I am signed in as a user with no profile
  And I have filled out my personal name and full name elsewhere
  When I try to go the home page
  Then I should see the dashboard
  
Scenario: Can leave first page if first page has been completed
  Given I am signed in as a user with no profile
  And I have filled out my personal name and full name elsewhere
  When I go to the profile editor
  Then I should see links to the other sections
  And I should see a save and exit button
  
@javascript
Scenario: Complete profile editing
  Given I am signed out
  When I visit the sign up page
  And I fill in my email address and a password
  And I submit the form
  And I fill in my personal name details
  And I go to the next stage
  And I fill in my formal name details
  And I click twice to add alternate names
  And I add a name I like and one I dislike
  And I go to the next stage
  And I fill in my pronunciation
  And I go to the next stage
  And I select my pronouns as she/her
  And I select the running example
  And I go to the next stage
  And I click to add an image
  And I attach my likeness
  And I accept the defaults in the image editor
  And I go to the next stage
  And I click twice to add a link
  And I fill in my Twitter and LinkedIn details
  And I go to the next stage
  And I click to finish
  Then I should be on the dashboard
  And my profile should be completed successfully
  And both my links should be added
  And both my alternate names should be added correctly
  And my likeness should be cropped and converted

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
  And I go to the next stage
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

@javascript
Scenario: Delete a link
  Given I am signed in as a user with a complete profile
  When I visit the dashboard
  And I click the edit button in the links box
  And I click to delete the first link
  And I click to save and exit
  Then my profile should only have one link attached

@javascript
Scenario: Delete an alternate name
  Given I am signed in as a user with a complete profile
  When I visit the dashboard
  And I click the edit button in the variants box
  And I click to delete the first alternate name
  And I click to save and exit
  Then my profile should only have two alternate names attached

@javascript
Scenario: Change pronunciation of
  Given I am signed in as a user with a complete profile
  When I visit the dashboard
  And I click the edit button in the pronunciation box
  And I select my personal name from the dropdown
  Then the hints on the page should update to my personal name

Scenario: Save change to pronunciation of
  Given I am signed in as a user with a complete profile
  When I visit the dashboard
  And I click the edit button in the pronunciation box
  And I select my personal name from the dropdown
  And I click to save and exit
  Then I should see the correct form of my name in the pronunciation box on the dashboard
