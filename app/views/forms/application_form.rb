class ApplicationForm < Superform::Rails::Form
  class CheckboxComponent < Superform::Rails::Components::CheckboxComponent
    def view_template(&)
      input(name: dom.name, type: :hidden, value: "0")
      div(class: 'flex items-center space-x-3') do
        Checkbox(value: "1", **attributes)
        label(for: dom.id, class: 'text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70') { field.label_string }
      end
    end
  end

  class InputComponent < Superform::Rails::Components::InputComponent
    def view_template(&)
      Input(**attributes, &)
      FormFieldError { field.error_message }
    end
  end

  class LabelComponent < Superform::Rails::Components::LabelComponent
    def view_template(&content)
      content ||= Proc.new { field.label_string }
      FormFieldLabel(**attributes, &content)
    end
  end

  class Field < Field
    def errors
      @object.errors[@key]
    end

    def error_message
      errors.to_sentence if errors.present?
    end

    def label_string
      @object.class.human_attribute_name(@key)
    end

    def checkbox(**attributes)
      CheckboxComponent.new(self, attributes:)
    end

    def input(**attributes)
      InputComponent.new(self, attributes:)
    end

    def label(**attributes, &)
      LabelComponent.new(self, attributes:, &)
    end
  end

  def form_class
    'space-y-4'
  end

  def form_tag(&)
    Form(action: form_action, method: form_method, class: form_class, **@attributes, &)
  end

  def row(component)
    FormField do
      render component.field.label
      render component
    end
  end

  def submit(value = submit_value, **attributes)
    Button(**attributes.merge(type: :submit)) { value }
  end
end
