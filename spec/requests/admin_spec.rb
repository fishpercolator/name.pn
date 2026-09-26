require 'rails_helper'

RSpec.describe 'Admin', type: :request do
  it 'sends anonymous visitors to sign in' do
    get admin_users_path
    expect(response).to redirect_to(new_user_session_path)
  end

  it 'turns away normal users' do
    sign_in create(:user)
    get admin_users_path
    expect(response).to redirect_to(root_path)
    expect(flash[:alert]).to eq(I18n.t('errors.not_authorized'))
  end

  it 'lets admins in' do
    sign_in create(:user, role: :admin)
    get admin_users_path
    expect(response).to have_http_status(:ok)
  end
end
