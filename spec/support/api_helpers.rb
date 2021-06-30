require 'devise/jwt/test_helpers'

module Request
  # Inspired by http://aalvarez.me/blog/posts/testing-a-rails-api-with-rspec.html
  module ApiHelpers
    # Get a JWT "Bearer xxxx" header for the given client
    def jwt(client)
      Devise::JWT::TestHelpers.auth_headers({}, client)['Authorization']
    end
    
    # Parse the response as JSON
    def jr
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end

RSpec.configure do |config|
  config.include Request::ApiHelpers
end
