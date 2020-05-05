class HomeController < ApplicationController
  skip_after_action :verify_policy_scoped
  skip_after_action :verify_authorized
  
  def index
    if user_signed_in?
      render 'user_home'
    else
      render 'anon_home'
    end
  end

  def manifest
  end

  def offline
  end
end
