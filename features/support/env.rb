ENV['RAILS_ENV'] = 'test'
require './config/environment'

require 'database_cleaner'
require 'email_spec/spinach'
require 'capybara-screenshot/spinach'
require 'spinach/rspec/mocks'
require 'capybara/cuprite'
require './spec/support/fixtures'

DatabaseCleaner.strategy = :truncation
Spinach.hooks.before_scenario { DatabaseCleaner.clean }

Capybara.register_driver :cuprite do |app|
  Capybara::Cuprite::Driver.new app, {
    #logger: $stdout,
    window_size: [1280, 900],
    browser_options: {
      'disable-gpu' => nil,
      'no-sandbox'  => nil,
      'unsafely-treat-insecure-origin-as-secure' => nil,
      'use-fake-device-for-media-stream' => nil,
      'use-fake-ui-for-media-stream' => nil,
      'use-file-for-fake-audio-capture' => (Rails.root + 'spec/fixtures/files/pronunciation.wav').to_s
    }
  }
end

Capybara.javascript_driver = :cuprite

class Spinach::FeatureSteps
  include RSpec::Matchers
  include FactoryBot::Syntax::Methods
end

Spinach.hooks.before_scenario do
  include RSpec::Mocks::ExampleMethods
  # Make sure the seed data (pronouns) are loaded before every test
  Rails.application.load_seed
end

Spinach.hooks.after_run do
  FileUtils.rm_rf(Rails.root + 'tmp/storage')
end
