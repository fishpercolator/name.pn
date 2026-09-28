require 'rails_helper'

RSpec.describe 'Public profiles', type: :request do
  let(:user) { create :user, :basic_profile }

  it 'renders a name badge image' do
    get user_path(user, format: :png)
    expect(response).to have_http_status(:ok)
    expect(response.media_type).to eq('image/png')
    expect(response.body).to start_with("\x89PNG".b)
  end
end
