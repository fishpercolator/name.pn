FactoryBot.define do
  factory :pronoun_set do
    nominative { "they" }
    oblique { "them" }
    possessive_determiner { "their" }
    possessive { "theirs" }
    reflexive { "themself" }
    copula { "are" }
    initialize_with { PronounSet.find_or_create_by(nominative: nominative) }
    trait :they
    trait :he do
      nominative { "he" }
      oblique { "him" }
      possessive_determiner { "his" }
      possessive { "his" }
      reflexive { "himself" }
      copula { "is" }
    end
    trait :she do
      nominative { "she" }
      oblique { "her" }
      possessive_determiner { "her" }
      possessive { "hers" }
      reflexive { "herself" }
      copula { "is" }
    end
  end
end
