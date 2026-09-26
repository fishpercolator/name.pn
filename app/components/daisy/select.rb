class Components::Daisy::Select < Components::Daisy::Field
  def initialize(builder, attribute, choices:, include_blank: false, **attributes)
    super(builder, attribute, **attributes)
    @choices = choices
    @include_blank = include_blank
  end

  def view_template
    @builder.select(@attribute, @choices, { include_blank: @include_blank }, mix({ class: ['select', ('select-error' if error?)] }, @attributes))
  end
end
