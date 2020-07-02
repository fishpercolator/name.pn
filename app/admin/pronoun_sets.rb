ActiveAdmin.register PronounSet do
  include ActiveAdmin::SortableTable
  
  config.sort_order = 'position_asc'
  
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
  end

end
