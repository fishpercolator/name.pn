class AddPronounlessStyleToUsers < ActiveRecord::Migration[7.0]
  def change
    create_enum :user_pronounless_style, %i[none unknown any]
    add_column :users, :pronounless_style, :enum, enum_type: :user_pronounless_style, null: true, default: nil
  end
end
