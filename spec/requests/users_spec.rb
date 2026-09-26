require 'rails_helper'

RSpec.describe 'Public profiles', type: :request do
  let(:user) { create :user, :basic_profile }

  it 'renders a name badge image' do
    get user_path(user, format: :png)
    expect(response).to have_http_status(:ok)
    expect(response.media_type).to eq('image/png')
    expect(response.body).to start_with("\x89PNG".b)
  end

  it 'falls back to the user\'s own pronouns when the URL\'s aren\'t known' do
    get user_path(user, nominative: 'xe', oblique: 'xem')
    expect(response.body).to include('My pronouns are she/her.')
  end

  it 'links social previews to the name badge' do
    get user_path(user)
    page = Nokogiri::HTML(response.body)
    expect(page.at_css('meta[property="og:image"]')['content']).to eq(user_url(user, format: :png))
    expect(page.at_css('meta[property="og:title"]')['content']).to include('Audrey Horne')
  end
end
