require 'rails_helper'

RSpec.describe 'Profile wizard', type: :request do
  let(:user) { create :user, :full_profile }
  before { sign_in user }

  it 'deletes the likeness and stays on its step' do
    patch profile_path(:likeness), params: {button: 'delete_likeness'}
    expect(response).to redirect_to(profile_path(:likeness))
    expect(user.reload.likeness).not_to be_attached
  end

  it 'deletes the pronunciation recording' do
    patch profile_path(:pronunciation), params: {user: {pronunciation: {delete: '1'}}}
    expect(response).to redirect_to(profile_path(:variants))
    expect(user.reload.pronunciation).not_to be_attached
  end

  it 'saves an uploaded likeness over JSON and returns its thumbnail' do
    patch profile_path(:likeness, format: :json), params: {user: {likeness: fixture_file_upload('likeness.png', 'image/png')}}
    expect(response).to have_http_status(:ok)
    expect(response.parsed_body['url']).to include('likeness.png')
  end

  it 'stays on a step that doesn\'t validate' do
    patch profile_path(:personal_name), params: {user: {full_name: ''}}
    expect(response).to have_http_status(:unprocessable_content)
    expect(response.body).to include('profile-form')
    expect(user.reload.full_name).to eq('Audrey Horne')
  end
end
