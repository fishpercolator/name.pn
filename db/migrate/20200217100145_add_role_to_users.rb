class AddRoleToUsers < ActiveRecord::Migration[5.2]
  def up
    create_enum :user_role, %i[user admin]
    add_column :users, :role, :user_role, null: false, default: :user
  end
  def down
    remove_column :users, :role
    drop_enum :user_role
  end
end
