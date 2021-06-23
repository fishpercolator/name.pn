class CreateClients < ActiveRecord::Migration[6.1]
  def change
    create_table :clients do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :jti, null: false

      t.timestamps
    end
    add_index :clients, :jti
  end
end
