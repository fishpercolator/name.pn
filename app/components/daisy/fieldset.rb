class Components::Daisy::Fieldset < Components::Base
  def view_template(&)
    fieldset(class: 'fieldset text-base', &)
  end

  def legend(text, for:)
    label(for: grab(for:), class: 'fieldset-legend block') { text }
  end
end
