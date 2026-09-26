require 'rails_helper'

RSpec.describe 'API authentication', type: :request do
  let(:client) { create :client }
  let(:user) { create :user, :basic_profile }

  def get_user(authorization)
    get api_v1_user_path(user), headers: {'Authorization' => authorization}
  end

  it 'rejects a malformed token' do
    get_user 'Bearer not-a-jwt'
    expect(response).to have_http_status(:unauthorized)
  end

  it 'rejects a revoked token' do
    authorization = jwt(client)
    Client.revoke_jwt(nil, client)
    get_user authorization
    expect(response).to have_http_status(:unauthorized)
  end

  it 'rejects the token of a deleted client' do
    authorization = jwt(client)
    client.destroy!
    get_user authorization
    expect(response).to have_http_status(:unauthorized)
  end
end
