class Components::UI::Hint < Components::Base
  def initialize(**attributes)
    @attributes = attributes
  end

  def view_template(&)
    div(**mix({ class: 'text-base text-muted' }, @attributes), &)
  end
end
