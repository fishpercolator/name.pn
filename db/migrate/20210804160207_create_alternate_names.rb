class CreateAlternateNames < ActiveRecord::Migration[6.1]
  def up
    create_enum :alternate_name_category, %i[variant nickname wrong]
    create_table :alternate_names do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name, null: false
      t.column :category, :alternate_name_category, null: false, default: :variant

      t.timestamps
    end
  end
  def down
    drop_table :alternate_names
    drop_enum :alternate_name_category
  end
end
