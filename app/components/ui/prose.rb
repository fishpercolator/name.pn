class Components::UI::Prose < Components::Base
  def initialize(**attributes)
    @attributes = attributes
  end

  def view_template(&)
    article(**mix({ class: 'prose prose-xl mx-auto w-full px-4 py-12 prose-a:text-secondary prose-table:block prose-table:overflow-x-auto prose-table:text-[1em]' }, @attributes), &)
  end
end
