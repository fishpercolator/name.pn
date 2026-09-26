class ApplicationMarkdown < MarkdownRails::Renderer::Rails
  # These flags control features in the Redcarpet renderer, which you can read
  # about at https://github.com/vmg/redcarpet#and-its-like-really-simple-to-use
  # Make sure you know what you're doing if you're using this to render user inputs.
  def enable
    [:tables, :with_toc_data]
  end

  # Render the page's first "# " heading as its PageTitle, like other views
  def preprocess(markdown)
    markdown.sub(/^# (.+)$/) { view_context.render(Components::UI::PageTitle.new($1.strip)) }
  end
end
