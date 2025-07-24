class PagesController < ApplicationController
  skip_after_action :verify_authorized

  layout -> { Components::ShellLayout.new }

  # A frozen hash of valid pages converted to their Component names
  PAGES = %w[
    about
    privacy
    terms
    guides/phonetic
  ].to_h { [it, Views::Pages.const_get(it.camelize)] }.freeze

  def page
    if PAGES.key? params[:path]
      render PAGES[params[:path]]
    else
      raise AbstractController::ActionNotFound
    end
  end
end
