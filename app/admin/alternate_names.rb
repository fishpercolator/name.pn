ActiveAdmin.register AlternateName do
  permit_params :user_id, :name, :category
  
  index do
    selectable_column
    id_column
    column :user
    column :name
    column :category
    actions
  end
  
  show do
    attributes_table do
      row :id
      row :user
      row :name
      row :category
      row :created_at
      row :updated_at
    end
  end
  
  form do |f|
    f.inputs do
      f.input :user
      f.input :name
      f.input :category, as: :select
    end
    f.actions
  end
end
