class HomeController < ApplicationController
  skip_after_action :verify_policy_scoped
  skip_after_action :verify_authorized
  def index
  end

  def manifest
  end

  def offline
  end
end
