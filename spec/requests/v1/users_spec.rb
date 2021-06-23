require 'swagger_helper'

RSpec.describe 'v1/users', type: :request do

  path '/v1/users/{slug}' do
    parameter name: 'slug', in: :path, type: :string, description: 'The slug of the user you want to retrieve', example: 'abby-yates'

    let!(:user) { create :user, :full_profile }

    get 'show user' do
      produces 'application/json'
                  
      response 200, 'successful' do
        let(:slug) { 'audrey-horne' }
        
        schema({
          '$ref': '#/components/schemas/User'
        })
        run_test!
      end
      
      response 404, 'not found' do
        let(:slug) { 'annie-blackburn' }
        run_test!
      end
    end
  end
end
