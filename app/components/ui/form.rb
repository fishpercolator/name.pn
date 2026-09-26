# Our stand-in for simple_form: it wraps form_with and renders each field as
# a daisyUI fieldset with its label, error and hint.
class Components::UI::Form < Components::Base
  include Phlex::Rails::Helpers::FormWith

  def initialize(builder: nil, **options)
    @builder = builder
    @options = options
  end

  def view_template(&)
    return yield(self) if @builder

    form_with(**@options) do |builder|
      @builder = builder
      yield self
    end
  end

  def field(attribute, as: nil, label: nil, hint: nil, fieldset_attributes: {}, **attributes)
    labelled(attribute, label:, hint:, **fieldset_attributes) do
      input(attribute, as: as || input_type(attribute), **mix({ class: 'w-full' }, attributes))
    end
  end

  def select(attribute, choices:, include_blank: false, label: nil, hint: nil, fieldset_attributes: {}, **attributes)
    labelled(attribute, label:, hint:, **fieldset_attributes) do
      Select(@builder, attribute, choices:, include_blank:, **mix({ class: 'w-full' }, attributes))
    end
  end

  def checkbox(attribute, label: nil, hint: nil, fieldset_attributes: {}, **attributes)
    Fieldset(**fieldset_attributes) do
      label(for: id_for(attribute), class: 'cursor-pointer [&_a]:link') do
        input(attribute, as: :checkbox, **attributes)
        span { label || label_text(attribute) }
      end
      feedback(attribute, hint)
    end
  end

  def input(attribute, as: :text, **attributes)
    case as
    when :checkbox then Checkbox(@builder, attribute, **attributes)
    when :file then FileInput(@builder, attribute, **attributes)
    else Input(@builder, attribute, type: as, placeholder: placeholder_text(attribute), **attributes)
    end
  end

  def hidden(attribute) = @builder.hidden_field(attribute)

  def error(attribute) = FieldError(errors_on(attribute).first)

  def submit(text, variant: :secondary, **attributes)
    Button(type: :submit, variant:, **attributes) { text }
  end

  def id_for(attribute) = @builder.field_id(attribute)

  def object = @builder.object

  def fields_for(association, record = nil, **options, &row)
    @builder.fields_for(association, record, options) { |builder| capture { Form(builder:, &row) }.html_safe }
  end

  def nested(association, add:, &row)
    div(class: 'space-y-3', data: { controller: 'nested-form', nested_form_wrapper_selector_value: '.nested-form-wrapper' }) do
      template(data: { nested_form_target: 'template' }) do
        fields_for(association, new_record(association), child_index: 'NEW_RECORD') { nested_row(it, &row) }
      end
      fields_for(association) { nested_row(it, &row) }
      div(data: { nested_form_target: 'target' })
      Button(variant: :success, icon: 'plus-box', data: { action: 'nested-form#add' }) { add }
    end
  end

  def remove(text, **attributes)
    Button(variant: :danger, icon: 'delete', data: { action: 'nested-form#remove' }, **attributes) { text }
  end

  private

  def labelled(attribute, label:, hint:, **attributes)
    Fieldset(**attributes) do |set|
      set.legend(label || label_text(attribute), for: id_for(attribute))
      yield
      feedback(attribute, hint)
    end
  end

  def nested_row(row)
    div(class: 'nested-form-wrapper rounded-box border border-base-300 bg-base-100 p-4', data: { new_record: row.object.new_record? }) do
      yield row
      row.hidden :_destroy
    end
  end

  def new_record(association) = @builder.object.association(association).klass.new

  def feedback(attribute, hint)
    error(attribute)
    hint ||= hint_text(attribute)
    Hint(size: :sm, class: 'hint') { hint } if hint
  end

  def errors_on(attribute) = @builder.object.try(:errors)&.[](attribute) || []

  def input_type(attribute)
    case attribute.to_s
    when /password/ then :password
    when 'email' then :email
    when /url\z/ then :url
    else :text
    end
  end

  def label_text(attribute) = lookup(:label, attribute) || attribute_name(attribute)

  def hint_text(attribute) = lookup(:hint, attribute)

  def placeholder_text(attribute) = lookup(:placeholder, attribute)

  def attribute_name(attribute) = @builder.object.class.try(:human_attribute_name, attribute) || attribute.to_s.humanize

  def lookup(kind, attribute)
    t(:"#{attribute}_html", scope: [:helpers, kind, *model_scope], default: [attribute.to_sym, ''].freeze).presence
  end

  def model_scope = @builder.object_name.to_s.gsub(/\[(\w+?)(?:_attributes)?\](?:\[\w+\])?/, '.\1').split('.')
end
