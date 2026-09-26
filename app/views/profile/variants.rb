class Views::Profile::Variants < Views::Profile::Step
  def view_template
    wizard_step do |form|
      form.field :envelope_name
      form.field :formal_name
      form.field :email_name
      subheading t('.alternate_names')
      Blurb(t('.alternate_names_blurb'))
      form.nested(:alternate_names, add: t('.add_alternate_name')) do |alternate_name|
        div(class: 'alternate_name-fields') do
          alternate_name.field :name
          alternate_name.select :category, choices: choices(AlternateName.categories.keys, scope: 'alternate_name_form_categories')
          div(class: 'mt-2 flex justify-end') do
            alternate_name.remove t('.remove')
          end
        end
      end
    end
  end
end
