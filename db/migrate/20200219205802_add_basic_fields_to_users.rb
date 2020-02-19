class AddBasicFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :full_name, :string
    add_column :users, :personal_name, :string
    add_column :users, :formal_name, :string
    add_column :users, :envelope_name, :string
    add_column :users, :phonetic, :string
  end
end
