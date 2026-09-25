class Views::Profile::Links < Views::Profile::Step
  def view_template
    wizard_step do |form|
      form.nested(:links, add: t('.add_link')) do |link|
        div(class: 'link-fields flex flex-wrap items-end gap-x-4 sm:flex-nowrap') do
          div(class: 'grow') { link.field :title }
          div(class: 'grow') { link.field :url }
          link.remove t('.remove'), class: 'mb-2'
        end
      end
    end
  end
end
