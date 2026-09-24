class Components::Daisy::Checkbox < Components::Daisy::Field
  def initialize(builder, attribute, checked_value: '1', unchecked_value: '0', **attributes)
    super(builder, attribute, **attributes)
    @values = [checked_value, unchecked_value]
  end

  def view_template
    raw @builder.checkbox(@attribute, mix({ class: ['checkbox me-2 align-middle bg-base-100', ('checkbox-error' if error?)] }, @attributes), *@values)
  end
end
