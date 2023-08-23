class AddEmailNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :email_name, :string
  end
end
