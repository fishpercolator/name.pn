ActiveAdmin.register Link do
  permit_params :user_id, :title, :url
  
  index do
    selectable_column
    id_column
    column :user
    column :title
    column(:url) {|l| link_to l.url, l.url }
    actions
  end
  
  show do
    attributes_table do
      row :id
      row :user
      row :title
      row(:url) {|l| link_to l.url, l.url }
      row :created_at
      row :updated_at
    end
  end
end
