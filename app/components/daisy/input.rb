class Components::Daisy::Input < Components::Daisy::Field
  def initialize(builder, attribute, type: :text, **attributes)
    super(builder, attribute, **attributes)
    @type = type
  end

  def view_template
    raw @builder.public_send(:"#{@type}_field", @attribute, **mix({ class: ['input w-full', ('input-error' if error?)] }, @attributes))
  end
end
