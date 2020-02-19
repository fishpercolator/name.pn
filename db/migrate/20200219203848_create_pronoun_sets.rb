class CreatePronounSets < ActiveRecord::Migration[6.0]
  def change
    create_table :pronoun_sets do |t|
      t.string :nominative
      t.string :oblique
      t.string :possessive_determiner
      t.string :possessive
      t.string :reflexive
      t.string :copula

      t.timestamps
    end
  end
end
