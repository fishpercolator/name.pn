module Request
  # Inspired by http://aalvarez.me/blog/posts/testing-a-rails-api-with-rspec.html
  module ApiHelpers
    # Parse the response as JSON
    def jr
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end

RSpec.configure do |config|
  config.include Request::ApiHelpers
end
