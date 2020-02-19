class CreateJoinTableUsersPronounSets < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :pronoun_sets do |t|
      # t.index [:user_id, :pronoun_set_id]
      # t.index [:pronoun_set_id, :user_id]
    end
  end
end
