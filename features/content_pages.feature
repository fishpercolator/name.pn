Feature: Content pages

Scenario: About
  Given I am signed out
  When I visit the home page
  And I click on "About" in the navbar
  Then I should see a page titled "About name.pn"

Scenario: Terms of use
  Given I am signed out
  When I visit the home page
  And I click on "Terms of use" in the footer
  Then I should see a page titled "Terms and conditions of use"

Scenario: Privacy policy
  Given I am signed out
  When I visit the home page
  And I click on "Privacy policy" in the footer
  Then I should see a page titled "Privacy policy"

Scenario: Phonetic spelling guide
  Given I am signed in
  When I visit the profile editing page for pronunciation
  And I click the link to the phonetic spelling guide
  Then I should see a page titled "How to write a phonetic spelling"
