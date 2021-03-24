require "active_support/testing/file_fixtures"

RSpec.configure do |config|
  config.after(:all) do
    FileUtils.rm_rf(Rails.root + 'tmp/storage')
  end
end

class Spinach::FeatureSteps
  include ActionDispatch::TestProcess
  include ActiveSupport::Testing::FileFixtures
  self.file_fixture_path = Rails.root + 'spec/fixtures/files'
end

FactoryBot::SyntaxRunner.class_eval do
  include ActionDispatch::TestProcess
  include ActiveSupport::Testing::FileFixtures
  self.file_fixture_path = Rails.root + 'spec/fixtures/files'
end
