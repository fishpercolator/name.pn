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
      render Views::Home::Anon
    end
  end

  def service_worker
    # The list of things to cache for offline mode
    @cache = [
      offline_path,
      manifest_path(format: :json),
      view_context.asset_path('application.js'),
      view_context.asset_path('application.css'),
      view_context.asset_path('favicon.ico'),
      view_context.asset_path('logo.svg'),
    ]
  end

  def manifest
  end

  def offline
  end
end
