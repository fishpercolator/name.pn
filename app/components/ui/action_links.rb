class Components::UI::ActionLinks < Components::Base
  def initialize(**attributes)
    @attributes = attributes
  end

  def view_template(&)
    div(**mix({ class: 'not-prose my-8 flex flex-col items-center gap-3' }, @attributes), &)
  end

  def link(href, icon: nil, &)
    Button(href:, icon:, variant: :secondary, outline: true, class: 'h-auto py-2 sm:btn-lg', &)
  end
end
