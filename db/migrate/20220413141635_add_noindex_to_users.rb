class AddNoindexToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :noindex, :boolean, null: false, default: false
  end
end
