require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do

  path '/api/v1/users/{slug}' do
    parameter name: 'slug', in: :path, type: :string, description: 'The slug of the user you want to retrieve', example: 'abby-yates'

    let!(:user) { create :user, :full_profile }

    get 'show user' do
      produces 'application/json'
      
      let(:slug) { 'audrey-horne' }
            
      response 200, 'successful' do
        schema({
          '$ref': '#/components/schemas/User'
        })
        run_test!
      end
    end
  end
end
