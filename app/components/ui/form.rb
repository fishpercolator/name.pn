# Our stand-in for simple_form: it wraps form_with and renders each field as
# a daisyUI fieldset with its label, error and hint.
class Components::UI::Form < Components::Base
  include Phlex::Rails::Helpers::FormWith

  def initialize(**options)
    @options = options
  end

  def view_template
    form_with(**@options) do |builder|
      @builder = builder.unwrap
      yield self
    end
  end

  def field(attribute, as: nil, label: nil, hint: nil, **attributes)
    Fieldset do |fieldset|
      fieldset.legend(label || label_text(attribute), for: @builder.field_id(attribute))
      input(attribute, as: as || input_type(attribute), **attributes)
      feedback(attribute, hint)
    end
  end

  def checkbox(attribute, label: nil, hint: nil, **attributes)
    Fieldset do
      label(for: @builder.field_id(attribute), class: 'cursor-pointer [&_a]:link') do
        Checkbox(@builder, attribute, **attributes)
        span { label || label_text(attribute) }
      end
      feedback(attribute, hint)
    end
  end

  def input(attribute, as: :text, **attributes)
    Input(@builder, attribute, type: as, placeholder: placeholder_text(attribute), **attributes)
  end

  def hidden(attribute) = raw(@builder.hidden_field(attribute))

  def submit(text, variant: :secondary, **attributes)
    Button(type: :submit, variant:, **attributes) { text }
  end

  private

  def feedback(attribute, hint)
    FieldError(@builder.object.errors[attribute].first)
    hint ||= hint_text(attribute)
    Hint(size: :sm, class: 'hint') { hint } if hint
  end

  def input_type(attribute)
    case attribute.to_s
    when /password/ then :password
    when 'email' then :email
    when /url\z/ then :url
    else :text
    end
  end

  def label_text(attribute) = lookup(:label, attribute, default: @builder.object.class.human_attribute_name(attribute))

  def hint_text(attribute) = lookup(:hint, attribute, default: nil)

  def placeholder_text(attribute) = lookup(:placeholder, attribute, default: nil)

  def lookup(kind, attribute, default:) = t(attribute, scope: [:helpers, kind, *model_scope], default:)

  def model_scope = @builder.object_name.to_s.gsub(/\[(\w+)_attributes\]\[\w+\]/, '.\1').split('.')
end
