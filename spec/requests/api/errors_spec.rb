require 'rails_helper'

RSpec.describe 'API errors', type: :request, show_exceptions: true do
  it 'describes the error in JSON' do
    get '/api/v1/no/such/thing'
    expect(response).to have_http_status(:not_found)
    expect(response.parsed_body).to eq('error' => 'not_found')
  end
end
