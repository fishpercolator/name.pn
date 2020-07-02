class AddPositionToPronounSets < ActiveRecord::Migration[6.0]
  def change
    add_column :pronoun_sets, :position, :integer
    add_index :pronoun_sets, :position
    
    up_only do
      PronounSet.order(:created_at).each.with_index(1) {|p,i| p.update_column :position, i}
    end
  end
end
