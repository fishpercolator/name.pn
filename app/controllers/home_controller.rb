class HomeController < ApplicationController
  skip_after_action :verify_policy_scoped
  skip_after_action :verify_authorized
  
  def index
    if user_signed_in?
      # Refuse to show the dashboard to people who haven't completed step 1
      return redirect_to(profile_index_path) if !current_user.basic_names_complete?
      render Views::Home::UserHome.new(current_user)
    else
      render Views::Home::AnonHome.new
    end
  end
end
