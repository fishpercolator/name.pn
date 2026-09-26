class Components::Daisy::Input < Components::Daisy::Field
  def initialize(builder, attribute, type: :text, prefix: nil, **attributes)
    super(builder, attribute, **attributes)
    @type = type
    @prefix = prefix
  end

  def view_template
    if @prefix
      prefixed_input
    else
      input_field
    end
  end

  private

  def classes = ['input', ('input-error' if error?)]

  def input_field = field(**mix({ class: classes }, @attributes))

  def field(**) = @builder.public_send(field_method, @attribute, **)

  def field_method
    method = :"#{@type}_field"
    return method if @builder.respond_to?(method)

    raise ArgumentError, "Rails has no #{method} form helper"
  end

  def prefixed_input
    label(**mix({ class: [*classes, 'gap-0'] }, @attributes.slice(:class))) do
      span { @prefix }
      field(**@attributes.except(:class))
    end
  end
end
