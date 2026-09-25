require 'rails_helper'

RSpec.describe 'Devise forms', type: :request do
  it 'take their labels and hints from the helpers translations' do
    get new_user_registration_path
    expect(response.body).to include(I18n.t('helpers.label.user.subscribe_to_mailing_list'))
      .and include(I18n.t('helpers.hint.user.subscribe_to_mailing_list'))
  end

  it 're-render with their errors when a submission fails' do
    post user_registration_path, params: { user: { email: 'not-an-email', password: 'short', password_confirmation: 'short' } }
    expect(response).to have_http_status(:unprocessable_entity)
    expect(response.body).to include('input-error').and include('class="error')
  end
end
