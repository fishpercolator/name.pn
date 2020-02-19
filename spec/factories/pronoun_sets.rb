FactoryBot.define do
  factory :pronoun_set do
    nominative { "they" }
    oblique { "them" }
    possessive_determiner { "their" }
    possessive { "theirs" }
    reflexive { "themself" }
    copula { "are" }
  end
end
