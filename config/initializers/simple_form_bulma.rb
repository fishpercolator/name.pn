SimpleForm.setup do |config|
  config.wrappers :bulma_string, class: :field do |b|
    b.use :html5
    b.use :placeholder
    b.optional :readonly
    b.use :label, class: :label
    b.wrapper :input_wrapper, tag: 'div', class: :control do |bb|
      bb.use :input, class: 'input', error_class: 'is-danger'
    end
    b.use :error, wrap_with: { tag: :span, class: 'help is-danger' }
    b.use :hint,  wrap_with: { tag: :span, class: 'help' }
  end
  config.wrappers :bulma_boolean, class: :field do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :input_wrapper, tag: 'div', class: :control do |bb|
      bb.use :label_input, error_class: 'is-danger'
    end
    b.use :error, wrap_with: { tag: :span, class: 'help is-danger' }
    b.use :hint,  wrap_with: { tag: :span, class: 'help' }
  end
  config.wrappers :bulma_text, class: :field do |b|
    b.use :html5
    b.use :placeholder
    b.optional :readonly
    b.use :label, class: :label
    b.wrapper :input_wrapper, tag: 'div', class: :control do |bb|
      bb.use :input, class: 'textarea', error_class: 'is-danger'
    end
    b.use :error, wrap_with: { tag: :span, class: 'help is-danger' }
    b.use :hint,  wrap_with: { tag: :span, class: 'help' }
  end
  config.wrappers :bulma_select, class: :field do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: :label
    b.wrapper :input_wrapper, tag: 'div', class: :control do |bb|
      bb.wrapper :input_wrapper, tag: 'div', class: :select do |bbb|
        bbb.use :input, class: '', error_class: 'is-danger'
      end
    end
    b.use :error, wrap_with: { tag: :span, class: 'help is-danger' }
    b.use :hint,  wrap_with: { tag: :span, class: 'help' }
  end
  config.button_class = 'button'
  config.error_method = :first
  config.error_notification_class = 'notification is-warning'
  config.label_class = nil
  config.generate_additional_classes_for = []
  config.wrapper_mappings = {
    boolean: :bulma_boolean,
    text: :bulma_text,
    string: :bulma_string,
    email: :bulma_string,
    password: :bulma_string,
    select: :bulma_select,
    enum: :bulma_select,
  }
end
