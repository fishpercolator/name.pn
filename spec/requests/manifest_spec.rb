require 'rails_helper'

RSpec.describe 'Offline support', type: :request do
  it 'serves a valid web manifest' do
    get manifest_path(format: :json)
    expect(response.parsed_body).to include('name', 'icons')
  end

  it 'serves a service worker that caches the offline page' do
    get serviceworker_path(format: :js)
    expect(response.body).to include('/offline')
    expect(response.body).not_to include('<html')
  end
end
