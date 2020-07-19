class UsersController < ApplicationController
  def show
    
    # If the user has entered an uppercase version of the name, try all lowercase
    if /[A-Z]/.match? params[:id]
      skip_authorization
      return redirect_to user_path(params[:id].downcase)
    end
    
    @user = User.friendly.find(params[:id])
    authorize @user
    
    pronouns = @user.pronoun_sets.map(&:to_s).join(', ')
    image = view_context.image_url('hello.png', only_path: false)
    
    set_meta_tags({
      title: @user.full_name,
      description: t('.description', name: @user.full_name, pronouns: pronouns),
      image: image,
      index: true,
      follow: true,
      og: {
        url: url_for(only_path: false),
        type: 'website',
        title: t('.hello_my_name_is', name: @user.full_name),
        description: t('.my_pronouns_are', pronouns: pronouns),
        image: {
          _: image,
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
        image: image
      }
    })
    
    render layout: 'user_profile'
  end
end
