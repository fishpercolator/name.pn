# frozen_string_literal: true

class Components::Prose < Components::Base
  register_output_helper :markdown

  def view_template(&)
    div(class: 'prose dark:prose-invert') do
      markdown(&)
    end
  end
end
