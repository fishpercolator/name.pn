class AddPronounExampleToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :pronoun_example, :string, null: :false, default: 'cooking'
  end
end
