class Views::Profile::Links < Views::Profile::Step
  protected

  def fields(form)
    form.nested(:links, add: t('.add_link')) { link(it) }
  end

  private

  def link(row)
    div(class: 'link-fields flex flex-wrap items-end gap-x-4 sm:flex-nowrap') do
      div(class: 'grow') { row.field :title }
      div(class: 'grow') { row.field :url }
      row.remove(t('.remove'), class: 'mb-2')
    end
  end
end
