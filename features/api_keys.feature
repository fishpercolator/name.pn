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

Scenario: Create API key without a name
  Given I am signed in
  When I visit the account page
  And I click to create a key without filling in its name
  Then I should be back on the account page
  And I should see a message saying the key needs a name
  And I should have no API keys

Scenario: Delete another user's API key
  Given I am signed in
  And another user has an API key
  When I try to delete that user's API key
  Then I should see a message saying I'm not permitted
  And that user's API key should still exist
