Feature: View profile

Scenario: Basic profile
  Given I am signed out
  And a user exists with a basic profile
  When I visit the path that is that user's slug
  Then I should not see the navbar
  And I should see a 'hello' card with the user's personal name and pronouns
  And I should see a box with the full name
  And I should see a usage guide for one set of pronouns
  And I should not see the formal name
  And I should not see a box with links
  And I should not see a pronunciation guide
  And I should not see a section for the user's likeness
  And I should see a link to the main site
  And the page should have a meta tag saying search engines can index it

Scenario: Pronoun style three
  Given I am signed out
  And a user exists with a basic profile
  And that user has set pronoun style to three
  When I visit the path that is that user's slug
  And I should see a 'hello' card with the user's personal name and pronoun in style three
  And I should see a usage guide for the pronouns in style three

Scenario: Profile URLs are case-insensitive
  Given I am signed out
  And a user exists with a basic profile
  When I visit the path that is a mixed-case version of that user's slug
  Then I should not see the navbar
  And I should see a 'hello' card with the user's personal name and pronouns
  
Scenario: Profile with text features filled out
  Given I am signed out
  And a user exists with a detailed profile
  When I visit the path that is that user's slug
  Then I should not see the navbar
  And I should see a 'hello' card with the user's personal name and pronouns
  And I should see a box with the full name
  And I should see a pronunciation guide
  And I should see the audio player
  And I should see the formal name
  And I should see sections for each of the completed types of alternate name
  And I should see a link to the main site
  And I should see the user's likeness
  And I should see a box with links in alphabetical order
  And the page should have a meta tag saying search engines can index it
  
Scenario: Profile with multiple pronouns
  Given I am signed out
  And a user exists with a basic profile
  And the user has multiple pronoun sets
  When I visit the path that is that user's slug
  Then I should see all the pronoun sets on one line each
  And I should see usage guides for all sets of pronouns
  
Scenario: Profile with multiple pronouns (URL containing one pronoun)
  Given I am signed out
  And a user exists with a basic profile
  And the user has multiple pronoun sets
  When I visit the path that is that user's slug with "she/her" on the end
  Then I should see only "she/her" in their name card
  And I should see a usage guide for one set of pronouns

Scenario: Alternative pronoun examples
  Given I am signed out
  And a user exists with a basic profile
  And the user has picked the 'running' pronoun example
  When I visit the path that is that user's slug
  Then I should see an appropriate usage guide for one set of pronouns

Scenario: User with noindex flag
  Given I am signed out
  And a user exists with a basic profile
  And that profile is marked with the noindex flag
  When I visit the path that is that user's slug
  Then I should not see the navbar
  And I should see a 'hello' card with the user's personal name and pronouns
  And I should see a link to the main site
  And the page should have a meta tag saying search engines cannot index it

Scenario: Cannot view incomplete profile
  Given I am signed out
  And a user exists who has not completed their profile
  When I visit the path that is that user's slug
  Then I should be redirected to the homepage with a forbidden error
