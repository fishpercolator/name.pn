require 'rails_helper'

RSpec.describe 'Error pages', type: :request do
  around do |example|
    env_config = Rails.application.env_config
    original = env_config.slice('action_dispatch.show_exceptions', 'action_dispatch.show_detailed_exceptions')
    env_config.merge!('action_dispatch.show_exceptions' => :all, 'action_dispatch.show_detailed_exceptions' => false)
    example.run
  ensure
    env_config.merge!(original)
  end

  it 'renders a missing page within the site layout' do
    get '/definitely-not-a-user'
    expect(response).to have_http_status(:not_found)
    expect(response.body).to include('site-navbar').and include(I18n.t('errors.not_found.title'))
  end
end
