class CreateLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :links do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :title
      t.string :url

      t.timestamps
    end
  end
end
