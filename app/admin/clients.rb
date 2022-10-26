ActiveAdmin.register Client do

  config.filters = false

  index do
    id_column
    column :user
    column :name
    column :created_at
    column :updated_at
  end

  show do
    attributes_table do
      row :id
      row :user
      row :name
      row :jti
      row :created_at
      row :updated_at
    end
  end
end
