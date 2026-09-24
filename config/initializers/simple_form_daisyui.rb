SimpleForm.setup do |config|
  config.wrappers :daisy_string, class: 'fieldset text-base' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :readonly
    b.use :label, class: 'fieldset-legend block [&_abbr]:no-underline'
    b.use :input, class: 'input w-full', error_class: 'input-error'
    b.use :error, wrap_with: { tag: :p, class: 'error text-sm text-error' }
    b.use :hint,  wrap_with: { tag: :p, class: 'hint text-sm text-muted [&_a]:link' }
  end
  config.wrappers :daisy_file, class: 'fieldset text-base' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'fieldset-legend block [&_abbr]:no-underline'
    b.use :input, class: 'file-input w-full', error_class: 'file-input-error'
    b.use :error, wrap_with: { tag: :p, class: 'error text-sm text-error' }
    b.use :hint,  wrap_with: { tag: :p, class: 'hint text-sm text-muted [&_a]:link' }
  end
  config.wrappers :daisy_slug, class: 'fieldset text-base' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :readonly
    b.use :label, class: 'sr-only'
    b.wrapper :input_wrapper, tag: 'label', class: 'input w-full gap-0', error_class: 'input-error' do |bb|
      bb.use :input
    end
    b.use :error, wrap_with: { tag: :p, class: 'error text-sm text-error' }
    b.use :hint,  wrap_with: { tag: :p, class: 'hint text-sm text-muted [&_a]:link' }
  end
  config.wrappers :daisy_boolean, class: 'fieldset text-base' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label_input, class: 'checkbox me-2 align-middle bg-base-100', error_class: 'checkbox-error'
    b.use :error, wrap_with: { tag: :p, class: 'error text-sm text-error' }
    b.use :hint,  wrap_with: { tag: :p, class: 'hint text-sm text-muted [&_a]:link' }
  end
  config.wrappers :daisy_text, class: 'fieldset text-base' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :readonly
    b.use :label, class: 'fieldset-legend block [&_abbr]:no-underline'
    b.use :input, class: 'textarea w-full', error_class: 'textarea-error'
    b.use :error, wrap_with: { tag: :p, class: 'error text-sm text-error' }
    b.use :hint,  wrap_with: { tag: :p, class: 'hint text-sm text-muted [&_a]:link' }
  end
  config.wrappers :daisy_select, class: 'fieldset text-base' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'fieldset-legend block [&_abbr]:no-underline'
    b.use :input, class: 'select w-full', error_class: 'select-error'
    b.use :error, wrap_with: { tag: :p, class: 'error text-sm text-error' }
    b.use :hint,  wrap_with: { tag: :p, class: 'hint text-sm text-muted [&_a]:link' }
  end
  config.button_class = 'btn'
  config.boolean_label_class = 'boolean-label cursor-pointer [&_a]:link'
  config.error_method = :first
  config.error_notification_class = 'alert alert-warning mb-4'
  config.label_class = nil
  config.generate_additional_classes_for = []
  config.wrapper_mappings = {
    boolean: :daisy_boolean,
    text: :daisy_text,
    string: :daisy_string,
    email: :daisy_string,
    url: :daisy_string,
    file: :daisy_file,
    password: :daisy_string,
    select: :daisy_select,
    enum: :daisy_select,
    slug: :daisy_slug
  }
end
