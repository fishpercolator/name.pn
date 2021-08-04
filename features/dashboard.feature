Feature: Dashboard

Scenario: View complete profile
  Given I am signed in as a user with a complete profile
  When I visit the dashboard
  Then I should see cards displaying every aspect of my name
  And I should see edit buttons for each section
  And I should see no warnings about sharing my URL
  And I should see my URL
  And I should see a pronoun version of my URL
  And I should see enabled buttons to view and copy my URL
  
Scenario: View incomplete profile
  Given I am signed in as a user with no profile
  And I have set my name and slug but not my pronouns
  When I visit the dashboard
  Then I should see cards with indications that things are not set
  And I should see warnings about sharing my URL
  And I should see my URL
  And I should see disabled buttons to view and copy my URL
