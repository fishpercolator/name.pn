# frozen_string_literal: true

class Components::Prose < Components::Base
  CM_OPTIONS = {
    render: {
      unsafe: true,
    },
    extension: {
      description_lists: true,
      header_ids: "",
      table: true,
    }
  }

  def initialize(md)
    @md = md
  end

  def view_template
    rendered = Commonmarker.to_html(@md, options: CM_OPTIONS)
    div(class: 'prose dark:prose-invert') do
      raw safe(rendered)
    end
  end
end
