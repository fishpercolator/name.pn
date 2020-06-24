class ProfileController < ApplicationController
  include Wicked::Wizard
  
  before_action :authenticate_user!
  before_action :set_user
  
  # The index is only used for redirecting in Wicked
  skip_after_action :verify_policy_scoped
  
  steps :personal_name, :formal_name, :pronunciation, :pronouns, :slug
  
  # Wicked methods needed in views
  helper_method :next_step, :previous_step

  def show
    render_wizard
  end
  
  def update
    @user.update_attributes(permitted_attributes @user)
    if @user.valid? && params[:button] == 'finish'
      jump_to Wicked::FINISH_STEP
    end
    render_wizard @user
  end
  
  private
  
  def set_user
    @user = current_user
    authorize @user, :update?
  end
  
end
