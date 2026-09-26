class Components::Daisy::Input < Components::Daisy::Field
  FIELDS = {
    text: :text_field,
    email: :email_field,
    password: :password_field,
    url: :url_field,
    number: :number_field
  }.freeze

  def initialize(builder, attribute, type: :text, **attributes)
    super(builder, attribute, **attributes)
    @type = type
  end

  def view_template
    raw @builder.public_send(FIELDS.fetch(@type), @attribute, **mix({ class: ['input w-full', ('input-error' if error?)] }, @attributes))
  end
end
