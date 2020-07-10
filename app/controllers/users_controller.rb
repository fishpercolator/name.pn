class UsersController < ApplicationController
  def show
    @user = User.friendly.find(params[:id])
    authorize @user
    
    pronouns = @user.pronoun_sets.map(&:to_s).join(', ')
    image = view_context.image_url('logo.png', only_path: false)
    
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
          width: 512,
          height: 512
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
