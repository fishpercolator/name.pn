Feature: Error pages

@javascript @show_exceptions
Scenario: Page not found
  Given I am signed out
  When I visit a page that doesn't exist
  Then I should see an error page saying the page wasn't found

@javascript @show_exceptions
Scenario: Something went wrong
  Given I am signed out
  And the home page is broken
  When I visit the home page
  Then I should see an error page saying something went wrong
