# DANGER! This parses Erb, which means arbitrary Ruby can be run. Make sure
# you trust the source of your markdown and that its not user input.

class ErbMarkdown < ApplicationMarkdown
  # Enables Erb to render for the entire doc before the markdown is rendered.
  # This works great, except when you have an `erb` code fence.
  def preprocess(html)
    # Read more about this render call at https://guides.rubyonrails.org/layouts_and_rendering.html
    # The text format stops annotate_rendered_view_with_filenames wrapping the
    # output in HTML comments, which would stop the first line parsing as Markdown.
    super(render(inline: html, handler: :erb, formats: [:text]))
  end
end
