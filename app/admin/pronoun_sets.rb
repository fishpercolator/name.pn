ActiveAdmin.register PronounSet do
  include ActiveAdmin::SortableTable
  
  config.sort_order = 'position_asc'
  config.filters = false
  
  permit_params :nominative, :oblique, :possessive_determiner, :possessive, :reflexive, :copula, :position

  index do
    selectable_column
    handle_column
    id_column
    column :nominative
    column :oblique
    column :possessive_determiner
    column :possessive
    column :reflexive
    column(:users) {|ps| ps.users.size}
    handle_column_js
  end

  show do |pronoun_set|
    attributes_table do
      row :id
      row :position
      row :nominative
      row :oblique
      row :possessive_determiner
      row :possessive
      row :reflexive
      row :copula
    end
    panel User.model_name.plural.titleize do
      table_for pronoun_set.users do
        column(:id) {|u| link_to u.id, user_url(u)}
        column(:slug) do |u| 
          if u.profile_complete?
            link_to(u.slug, user_url(u))
          elsif u.slug.present?
            u.slug
          else
            '-'
          end
        end
        column :full_name
      end
    end
  end

end
