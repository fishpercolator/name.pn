class RenamePronounSetsUsers < ActiveRecord::Migration[7.0]
  def change
    rename_table :pronoun_sets_users, :user_pronoun_sets
    add_column :user_pronoun_sets, :id, :primary_key
  end
end
