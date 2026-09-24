class Components::UI::Hint < Components::Base
  def initialize(**attributes)
    @attributes = attributes
  end

  def view_template(&)
    div(**mix({ class: 'text-muted [&_a]:link' }, @attributes), &)
  end
end
