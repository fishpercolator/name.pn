class Components::Daisy::Checkbox < Components::Daisy::Field
  def view_template
    raw @builder.checkbox(@attribute, **mix({ class: ['checkbox me-2 align-middle bg-base-100', ('checkbox-error' if error?)] }, @attributes))
  end
end
