Feature: API keys

Scenario: List API keys
  Given I am signed in
  And I have 3 API keys created
  When I visit the account page
  Then I should see my 3 API keys and their ages
  
@javascript
Scenario: Delete API key
  Given I am signed in
  And I have 3 API keys created
  When I visit the account page
  And I click to delete the first key & confirm the action
  Then I should be back on the account page
  And I should see a message saying my API key has been deleted
  And I should see my remaining 2 API keys
  
@javascript
Scenario: Create API key
  Given I am signed in
  And I have 3 API keys created
  When I visit the account page
  And I fill in a new key name
  And I click to create it
  Then I should be back on the account page
  And I should see a dialog with a JWT for me to copy
