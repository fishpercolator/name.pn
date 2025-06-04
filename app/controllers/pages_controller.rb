class PagesController < ApplicationController
  skip_after_action :verify_authorized

  layout -> { Components::ShellLayout.new }

  def show
    render Views::Pages.const_get(params[:id].camelize)
  rescue NameError
    # If const_get fails, raise a 404
    raise AbstractController::ActionNotFound
  end
end
