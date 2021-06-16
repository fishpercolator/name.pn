class AddIpaToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :ipa, :string
  end
end
