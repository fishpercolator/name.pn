class SlugInput < SimpleForm::Inputs::StringInput
  include Rails.application.routes.url_helpers
  delegate :default_url_options, to: ActionMailer::Base
  
  def input(wrapper_options = nil)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    root_part +
    @builder.text_field(attribute_name, merged_input_options)
  end
  
  def root_part
    content_tag(:span, root_url, class: 'field-slug__root')
  end
  
  def input_html_classes
    %w[field-slug__input]
  end
  
end
