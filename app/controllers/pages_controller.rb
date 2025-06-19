class PagesController < ApplicationController
  skip_after_action :verify_authorized

  layout -> { Components::ShellLayout.new }

  VALID_PAGES = %w[
    about
    privacy
    terms
    guides/phonetic
  ]

  def page
    if params[:path].in? VALID_PAGES
      render Views::Pages.const_get(params[:path].camelize)
    else
      raise AbstractController::ActionNotFound
    end
  end
end
