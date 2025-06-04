class PagesController < ApplicationController
  skip_after_action :verify_authorized

  layout -> { Components::ShellLayout.new }

  def about
    render Views::Pages::About
  end
end
