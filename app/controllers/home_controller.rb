class HomeController < ApplicationController
  protect_from_forgery except: :service_worker
  skip_after_action :verify_policy_scoped
  skip_after_action :verify_authorized
  
  def index
    if user_signed_in?
      # Refuse to show the dashboard to people who haven't completed step 1
      return redirect_to(profile_index_path) if !current_user.basic_names_complete?
      render 'user_home'
    else
      render 'anon_home'
    end
  end

  def service_worker
  end

  def manifest
  end

  def offline
  end
end
