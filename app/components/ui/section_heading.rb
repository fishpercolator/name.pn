class Components::UI::SectionHeading < Components::Base
  def initialize(**attributes)
    @attributes = attributes
  end

  def view_template(&)
    h2(**mix({ class: 'text-2xl font-bold' }, @attributes), &)
  end
end
