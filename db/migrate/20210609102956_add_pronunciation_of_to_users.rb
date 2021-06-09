class AddPronunciationOfToUsers < ActiveRecord::Migration[6.1]
  def up
    create_enum :user_name_variant, %i[full_name personal_name formal_name envelope_name]
    add_column :users, :pronunciation_of, :user_name_variant, null: false, default: :full_name
  end
  def down
    remove_column :users, :pronunciation_of
    drop_enum :user_name_variant
  end
end
