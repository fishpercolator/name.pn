# frozen_string_literal: true

class Views::Base < Components::Base
  # The `Views::Base` is an abstract class for all your views.

  # By default, it inherits from `Components::Base`, but you
  # can change that to `Phlex::HTML` if you want to keep views and
  # components independent.

  # Safe version of the equivalent helper in MetaTags
  def title(title = nil)
    view_context.set_meta_tags(title:) unless title.nil?
    view_context.meta_tags[:title]
  end
end
