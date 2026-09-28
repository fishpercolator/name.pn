Feature: Offline

@javascript
Scenario: Lose connection after visiting the site
  Given I am signed out
  And I have visited the site before
  When I lose my internet connection
  And I click on "About" in the navbar
  Then I should see the offline page
