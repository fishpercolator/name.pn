class Components::Daisy::Input < Components::Daisy::Field
  def initialize(builder, attribute, type: :text, **attributes)
    super(builder, attribute, **attributes)
    @type = type
  end

  def view_template
    raw @builder.public_send(field_method, @attribute, **mix({ class: ['input w-full', ('input-error' if error?)] }, @attributes))
  end

  private

  def field_method
    method = :"#{@type}_field"
    return method if @builder.respond_to?(method)

    raise ArgumentError, "Rails has no #{method} form helper"
  end
end
