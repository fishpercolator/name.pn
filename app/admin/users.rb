ActiveAdmin.register User do
  permit_params :email, :role, :password

  index do
    selectable_column
    id_column
    column :email
    column :role
    actions
  end

  filter :email
  filter :role

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :role, as: :select
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :email
      row :role
      row :created_at
      row :updated_at
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :reset_password_sent_at
    end
  end

  # Don't change password if password field is blank
  controller do
    def update
      if params[:user][:password].blank?
        params[:user].delete(:password)
      end
      super
    end
  end
end
