ENV['RAILS_ENV'] = 'test'
require './config/environment'

require 'database_cleaner'
require 'email_spec/spinach'
require 'capybara-screenshot/spinach'
require 'spinach/rspec/mocks'
require 'capybara/cuprite'

DatabaseCleaner.strategy = :truncation
Spinach.hooks.before_scenario { DatabaseCleaner.clean }

Capybara.register_driver :cuprite do |app|
  Capybara::Cuprite::Driver.new app, {
    window_size: [1280, 900],
    browser_options: {
      'disable-gpu' => nil,
      'no-sandbox'  => nil
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
end

Spinach.hooks.after_run do
  FileUtils.rm_rf(Rails.root + 'tmp/storage')
end
