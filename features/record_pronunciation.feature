Feature: Record pronunciation

This is difficult to test in an automated way

@javascript
Scenario: Recorder available (no recording)
  Given I am signed in
  And my user has no audio recorded already
  And I am using a browser with the ability to record audio
  And I have given permission to record audio
  When I visit the profile editing page for pronunciation
  Then I should see the recorder
  And I should not see the upload form and delete checkbox
  And the play button and delete button should be disabled
  
@javascript
Scenario: Recorder available (recording present)
  Given I am signed in
  And my user has audio recorded already
  And I am using a browser with the ability to record audio
  And I have given permission to record audio
  When I visit the profile editing page for pronunciation
  Then I should see the recorder
  And I should not see the upload form and delete checkbox
  And the play button and delete button should be available


Scenario: Recorder not available
  Given I am signed in
  And my user has no audio recorded already
  And I am not using a browser without the ability to record audio
  When I visit the profile editing page for pronunciation
  Then I should not see the recorder
  And I should see a message telling me to use a different browser
  And I should see the upload form and delete checkbox

@javascript
Scenario: Permission not given
  Given I am signed in
  And my user has audio recorded already
  And I am using a browser with the ability to record audio
  And I have not given permission to record audio
  When I visit the profile editing page for pronunciation
  Then I should see the permission button
  And I should not see the upload form and delete checkbox

@javascript
Scenario: Permission revoked
  Given I am signed in
  And my user has audio recorded already
  And I am using a browser with the ability to record audio
  And I have revoked permission to record audio
  When I visit the profile editing page for pronunciation
  Then I should see an error message
  And I should not see the upload form and delete checkbox

@javascript
Scenario: Player on public page
  Given I am signed out
  And a user exists with recorded audio
  And I visit that user's public URL
  Then I should see a player, and it should be attached to a valid audio element

@javascript
Scenario: Player not on public page
  Given I am signed out
  And a user exists without recorded audio
  And I visit that user's public URL
  Then I should not see a player

Scenario: Save recording
  Given I am signed in
  And my user has no audio recorded already
  When I visit the profile editing page for pronunciation
  And I make a short recording
  And I click to go to the next step
  Then my recording should be saved in storage

Scenario: Attempt to save very large recording
  Given I am signed in
  And my user has no audio recorded already
  When I visit the profile editing page for pronunciation
  And I make a recording that is too large
  And I click to go to the next step
  Then I should see an error requiring me to make a shorter recording
  And my recording should not be saved in storage
