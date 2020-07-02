ActiveAdmin.register User do
  permit_params :email, :role, :password, :full_name, :personal_name, :formal_name, :envelope_name, :phonetic, :pronoun_set_ids => []

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  index do
    selectable_column
    id_column
    column :email
    column :full_name
    column :role
    actions
  end

  filter :email
  filter :role
  filter :slug
  filter :full_name

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :slug
      f.input :role, as: :select
      f.input :full_name
      f.input :personal_name
      f.input :formal_name
      f.input :envelope_name
      f.input :phonetic
      f.input :pronoun_sets
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :email
      row(:slug) {|u| link_to u.slug, user_url(u)}
      row :role
      row :full_name
      row :personal_name
      row :formal_name
      row :envelope_name
      row :phonetic
      row :pronoun_sets
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
