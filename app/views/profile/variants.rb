class Views::Profile::Variants < Views::Profile::Step
  protected

  def fields(form)
    form.field :envelope_name
    form.field :formal_name
    form.field :email_name
    subheading(t('.alternate_names'))
    Blurb(t('.alternate_names_blurb'))
    form.nested(:alternate_names, add: t('.add_alternate_name')) { alternate_name(it) }
  end

  private

  def alternate_name(row)
    div(class: 'alternate_name-fields') do
      row.field :name
      row.field :category, as: :select, choices: choices(AlternateName.categories.keys, scope: 'alternate_name_form_categories')
      div(class: 'mt-2 flex justify-end') { row.remove(t('.remove')) }
    end
  end
end
