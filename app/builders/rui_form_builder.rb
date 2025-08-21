# frozen_string_literal: true

class RuiFormBuilder < ActionView::Helpers::FormBuilder
  def label(method, text = nil, options = {})
    content = text || object.class.human_attribute_name(method)
    @template.render RubyUI::FormFieldLabel.new(
      for: field_id(method),
      **options
    ) { block_given? ? yield : content }
  end

  def email_field(method, options = {})
    input_field(method, type: :email, **options)
  end

  def text_field(method, options = {})
    input_field(method, type: :text, **options)
  end

  def password_field(method, options = {})
    input_field(method, type: :password, **options)
  end

  def submit(value = nil, options = {})
    value, options = nil, value if value.is_a?(Hash)
    value ||= submit_default_value
    @template.render RubyUI::Button.new(
      type: :submit,
      **options,
    ) { value }
  end

  def labelled_checkbox(method, text = nil, options = {})
    content = text || object.class.human_attribute_name(method)
    options[:outer_class] ||= 'flex items-center space-x-3'
    options[:label_class] ||= 'text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70'
    
    @template.hidden_field_tag(field_name(method), '0', id: nil) +
    @template.content_tag(:div, class: options.delete(:outer_class)) do
      @template.render(RubyUI::Checkbox.new(
        id: field_id(method),
        name: field_name(method),
        value: '1',
        checked: ActiveModel::Type::Boolean.new.cast(object.public_send(method)),
        **options
      )) +
      @template.content_tag(:label, class: options.delete(:label_class), for: field_id(method)) { content }
    end
  end

  def errors(method)
    if object.errors.key?(method)
      @template.render(RubyUI::FormFieldError.new { object.errors[method].to_sentence })
    end
  end

  private

  def input_field(method, type:, **options)
    @template.render(RubyUI::Input.new(
      type:, 
      id: field_id(method), 
      name: field_name(method),
      value: object.public_send(method),
      **options
    ))
  end
end
