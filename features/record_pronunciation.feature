Feature: Record pronunciation

This is difficult to test in an automated way

@javascript
Scenario: Recorder available (no recording)
  Given I am signed in
  And my user has no audio recorded already
  And I am using a browser with the ability to record audio
  When I visit the profile editing page for pronunciation
  Then I should see the recorder
  And the play button and delete button should be disabled
  
@javascript
Scenario: Recorder available (recording present)
  Given I am signed in
  And my user has audio recorded already
  And I am using a browser with the ability to record audio
  When I visit the profile editing page for pronunciation
  Then I should see the recorder
  And the play button and delete button should be available

Scenario: Recorder not available
  Given I am signed in
  And my user has no audio recorded already
  And I am not using a browser without the ability to record audio
  When I visit the profile editing page for pronunciation
  Then I should not see the recorder
  And I should see a message telling me to use a different browser

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
