class AddPositionToPronounSetsUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :pronoun_sets_users, :position, :integer
    up_only do
      execute <<~SQL
        update pronoun_sets_users
        set position = pronoun_sets.position
        from pronoun_sets
        where pronoun_sets_users.pronoun_set_id = pronoun_sets.id
      SQL
    end
  end
end
