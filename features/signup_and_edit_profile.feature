Feature: Signup and edit profile

Scenario: Sign up takes user to profile editor
  Given I am signed out
  When I visit the sign up page
  And I fill in my email address and a password
  And I select to accept the terms
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

Scenario: Cannot proceed without accepting terms
  Given I am signed out
  When I visit the sign up page
  And I fill in my email address and a password
  And I submit the form
  Then I should see an error saying the terms must be accepted
  And my user should not be created

Scenario: Save and exit after basic profile
  Given I am signed out
  When I visit the sign up page
  And I fill in my email address and a password
  And I select to accept the terms
  And I submit the form
  And I fill in my personal name details
  And I go to the next stage
  And I select my pronouns as she/her
  And I select the running example
  And I go to the next stage
  And I leave my slug as the default
  And I click the save button in the optional blurb
  Then I should be on the dashboard
  And my profile should be completed enough to use

@javascript
Scenario: Pronoun selection boxes disabled when pronounless style selected
  Given I am signed out
  When I visit the sign up page
  And I fill in my email address and a password
  And I select to accept the terms
  And I submit the form
  And I fill in my personal name details
  And I go to the next stage
  And I select the pronounless style "none"
  Then the pronoun selection boxes should be disabled

@javascript
Scenario: Pronoun selection boxes enabled when pronounless style unselected
  Given I am signed out
  When I visit the sign up page
  And I fill in my email address and a password
  And I select to accept the terms
  And I submit the form
  And I fill in my personal name details
  And I go to the next stage
  And I select the pronounless style "N/A"
  Then the pronoun selection boxes should be enabled

Scenario: Save pronounless style
  Given I am signed out
  When I visit the sign up page
  And I fill in my email address and a password
  And I select to accept the terms
  And I submit the form
  And I fill in my personal name details
  And I go to the next stage
  And I select the pronounless style "none"
  And I go to the next stage
  And I leave my slug as the default
  And I click the save button in the optional blurb
  Then I should be on the dashboard
  And my profile should be completed enough to use
  And I should have a pronounless style and no pronouns saved in my user

@javascript
Scenario: Complete profile editing
  Given I am signed out
  When I visit the sign up page
  And I fill in my email address and a password
  And I select to accept the terms
  And I submit the form
  And I fill in my personal name details
  And I go to the next stage
  And I select my pronouns as she/her
  And I select the running example
  And I go to the next stage
  And I leave my slug as the default
  And I go to the next stage
  And I fill in my pronunciation
  And I go to the next stage
  And I fill in my formal name details
  And I click twice to add alternate names
  And I add a name I like and one I dislike
  And I go to the next stage
  And I click to add an image
  And I attach my likeness
  And I accept the defaults in the image editor
  And I go to the next stage
  And I click twice to add a link
  And I fill in my Twitter and LinkedIn details
  And I click to finish
  Then I should be on the dashboard
  And my profile should be completed successfully
  And both my links should be added
  And both my alternate names should be added correctly
  And my likeness should be cropped

Scenario: My slug is already taken
  Given I am signed out
  And an Audrey Horne profile already exists
  When I visit the sign up page
  And I fill in my email address and a password
  And I select to accept the terms
  And I submit the form
  And I fill in my personal name details
  And I go to the next stage
  And I select my pronouns as she/her
  And I go to the next stage
  And I fill in audrey-horne as a slug
  And I click the save button in the optional blurb
  Then I should still be on the slug-editing page
  And I should see a message telling me there was a conflict
  And I should see a suggested alternative name prefilled
  
Scenario: Save and exit early
  Given I am signed out
  When I visit the sign up page
  And I fill in my email address and a password
  And I select to accept the terms
  And I submit the form
  And I fill in my personal name details
  And I go to the next stage
  And I click to go to the variants page
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

Scenario: Mark as noindex
  Given I am signed in as a user with a complete profile
  When I visit the dashboard
  And I click the edit button in the URL box
  And I select the checkbox to hide from search engines
  And I click to save and exit
  Then my profile should be marked as noindex
  
@javascript
Scenario: Likeness is too large
  Given I am signed in as a user with a complete profile
  When I visit the dashboard
  And I click the edit button in the likeness box
  And I click to add an image
  And I attach a likeness that is too large
  Then I should see an error that the file is too large

@javascript
Scenario: Cancel likeness upload from cropper
  Given I am signed in as a user with a complete profile
  When I visit the dashboard
  And I click the edit button in the likeness box
  And I click to add an image
  And I attach my likeness
  And I cancel from the image editor
  Then I should be back on the likeness upload dashboard

Scenario: Reorder pronouns (no JavaScript)
  Given I am signed out
  When I visit the sign up page
  And I fill in my email address and a password
  And I select to accept the terms
  And I submit the form
  And I fill in my personal name details
  And I go to the next stage
  And I select my pronouns as she/her
  And I type 2 into the she/her position box
  And I select my pronouns as they/them
  And I type 1 into the they/them position box
  And I click to save and exit
  And I visit my profile page
  Then I should see my pronouns listed in the order they/them, she/her

@javascript
Scenario: Reordering boxes invisible when JavaScript on
  Given I am signed out
  When I visit the sign up page
  And I fill in my email address and a password
  And I select to accept the terms
  And I submit the form
  And I fill in my personal name details
  And I go to the next stage
  Then I should see pronoun checkboxes but no position boxes

@javascript
Scenario: No reorder (JavaScript enabled)
  Given I am signed out
  When I visit the sign up page
  And I fill in my email address and a password
  And I select to accept the terms
  And I submit the form
  And I fill in my personal name details
  And I go to the next stage
  And I select my pronouns as she/her
  And I select my pronouns as they/them
  And I click to save and exit
  And I visit my profile page
  Then I should see my pronouns listed in the order she/her, they/them

# https://github.com/rubycdp/cuprite/issues/178
@javascript @wip
Scenario: Reorder with drag-and-drop
  Given I am signed out
  When I visit the sign up page
  And I fill in my email address and a password
  And I select to accept the terms
  And I submit the form
  And I fill in my personal name details
  And I go to the next stage
  And I select my pronouns as she/her
  And I select my pronouns as they/them
  And I drag they/them to the top position
  And I click to save and exit
  And I visit my profile page
  Then I should see my pronouns listed in the order they/them, she/her
