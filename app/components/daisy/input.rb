class Components::Daisy::Input < Components::Daisy::Field
  def initialize(builder, attribute, type: :text, **attributes)
    super(builder, attribute, **attributes)
    @type = type
  end

  def view_template
    raw field(**mix({ class: ['input w-full', ('input-error' if error?)] }, @attributes))
  end

  private

  def field(**)
    return @builder.password_field(@attribute, **) if @type == :password

    @builder.text_field(@attribute, type: @type, **)
  end
end
