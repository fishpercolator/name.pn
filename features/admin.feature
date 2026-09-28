Feature: Admin

Scenario: Anonymous visitors must sign in
  Given I am signed out
  When I visit the admin
  Then I should be asked to sign in

Scenario: Normal users are turned away
  Given I am signed in
  When I visit the admin
  Then I should be on the home page with a message saying I'm not permitted

Scenario: Admins can browse every section
  Given I am signed in as an admin with an API key
  When I visit the admin
  Then I should see the admin dashboard
  And I should be able to view and edit a record in every section
