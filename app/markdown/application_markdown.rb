class ApplicationMarkdown < MarkdownRails::Renderer::Rails
  # These flags control features in the Redcarpet renderer, which you can read
  # about at https://github.com/vmg/redcarpet#and-its-like-really-simple-to-use
  # Make sure you know what you're doing if you're using this to render user inputs.
  def enable
    [:tables, :with_toc_data]
  end

  # Use the page's first "# " heading as its title, as other views do with
  # the `title` helper
  def preprocess(markdown)
    heading = markdown[/^# (.+)$/, 1]
    view_context.title(heading.strip) if heading
    markdown
  end
end
