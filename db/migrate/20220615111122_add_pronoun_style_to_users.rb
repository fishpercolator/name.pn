class AddPronounStyleToUsers < ActiveRecord::Migration[7.0]
  def change
    create_enum :user_pronoun_style, %i[two three]
    add_column :users, :pronoun_style, :enum, enum_type: :user_pronoun_style, null: false, default: :two
  end
end
