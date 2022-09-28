class UsersController < ApplicationController
  before_action :pronoun_sets_from_url
  
  def show
    
    # If the user has entered an uppercase version of the name, try all lowercase
    if /[A-Z]/.match? params[:id]
      skip_authorization
      return redirect_to user_path(params[:id].downcase)
    end
    
    @user = User.friendly.find(params[:id])
    authorize @user
    
    if @pronoun_sets.blank?
      @pronoun_sets = @user.pronoun_sets_with_preference
    end
    
    respond_to do |format|
      format.html do
        set_meta_tags(profile_meta_tags)
        render layout: 'user_profile'
      end
      format.png do
        send_data(@user.profile_image.read, filename: 'hello.png', type: 'image/png', disposition: 'inline')
      end
    end
  end
  
  private
  
  def pronoun_sets_from_url
    if params[:nominative].present?
      @pronoun_sets = PronounSet.where(nominative: params[:nominative].downcase, oblique: params[:oblique]&.downcase)
    end
  end
  
  def profile_meta_tags
    pronouns = @pronoun_sets.map(&:to_s).join(', ')    
    {
      title: @user.full_name,
      description: t('.description', name: @user.full_name, pronouns: pronouns),
      image: url_for(format: :png, only_path: false),
      (@user.noindex? ? :noindex : :index) => true,
      follow: true,
      og: {
        url: url_for(only_path: false),
        type: 'website',
        title: t('.hello_my_name_is', name: @user.full_name),
        description: t('.my_pronouns_are', pronouns: pronouns),
        image: {
          _: url_for(format: :png, only_path: false),
          width: 527,
          height: 352
        }
      },
      fb: {
        app_id: Rails.configuration.x.fb_app_id
      },
      twitter: {
        card: 'summary',
        site: Rails.configuration.x.twitter_app_id,
        title: t('.hello_my_name_is', name: @user.full_name),
        description: t('.my_pronouns_are', pronouns: pronouns),
        image: url_for(format: :png, only_path: false)
      }
    }
  end
  
end
