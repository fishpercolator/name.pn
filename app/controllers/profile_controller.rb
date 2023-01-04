class ProfileController < ApplicationController
  include Wicked::Wizard
  
  before_action :authenticate_user!
  before_action :set_user
  
  # The index is only used for redirecting in Wicked
  skip_after_action :verify_policy_scoped
  
  steps *%i[personal_name pronouns slug pronunciation variants likeness links]
  
  # Wicked methods needed in views
  helper_method :next_step, :previous_step

  def show
    render_wizard
  end
  
  def update
    if params[:button] == 'finish'
      @next_step = Wicked::FINISH_STEP
    end
    if params[:button] == 'delete_likeness'
      @next_step = step
      @user.likeness.purge
    end
    if params[:user].present?
      @user.assign_attributes(permitted_attributes @user)
    end
    if pronunciation[:delete].present?
      @user.pronunciation.purge
    elsif pronunciation[:data].present?
      @user.pronunciation.attach(io: pronunciation[:data], filename: 'pronunciation.webm', content_type: 'audio/webm', identify: false)
    end
    respond_to do |format|
      format.html { render_wizard @user }
      format.json do
        @user.save! 
        render json: {url: @user.likeness.attached? ? url_for(@user.likeness.variant(resize_to_limit: [300,300])) : nil} 
      end
    end
  end
    
  def process_resource!(resource, options = {})
    if !resource&.valid?
      @skip_to = nil
    else
      super
    end
  end
  
  # Users must complete the first step to continue
  def stuck_on_first_step?
    (@user.full_name.blank? || @user.personal_name.blank?)
  end
  helper_method :stuck_on_first_step?
  
  private
  
  def set_user
    @user = current_user
    authorize @user, :update?

    # Get the set of pronoun_sets the user hasn't selected and render them as user_pronoun_sets
    @additional_ups = PronounSet.where.not(id: @user.pronoun_sets).map {|ps| UserPronounSet.new(pronoun_set: ps, user: @user)}
  end

  def pronunciation
    params.dig(:user, :pronunciation) || {}
  end
  
end
