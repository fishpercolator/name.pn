class Components::Daisy::Fieldset < Components::Base
  def initialize(**attributes)
    @attributes = attributes
  end

  def view_template(&)
    fieldset(**mix({ class: 'fieldset text-base' }, @attributes), &)
  end

  def legend(text, for:)
    label(for: grab(for:), class: 'fieldset-legend block') { text }
  end
end
