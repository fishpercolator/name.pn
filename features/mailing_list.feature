Feature: Mailing list

@javascript
Scenario: Subscribe
  Given I am signed in
  And I am not subscribed to the mailing list
  When I visit the account page
  And I click to subscribe to the mailing list
  Then I should be subscribed to the mailing list
  And I should see that I am subscribed

@javascript
Scenario: Unsubscribe
  Given I am signed in
  And I am subscribed to the mailing list
  When I visit the account page
  And I click to unsubscribe from the mailing list
  Then I should not be subscribed to the mailing list
  And I should see that I am not subscribed
