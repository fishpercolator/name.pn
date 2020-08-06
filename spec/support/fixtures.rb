module FixtureHelpers
  def fixture(name)
    Rails.root.join('spec', 'fixtures', name)
  end
end

RSpec.configure do |config|
  config.include FixtureHelpers
  config.after(:all) do
    FileUtils.rm_rf(Rails.root + 'tmp/storage')
  end
end

class Spinach::FeatureSteps
  include ActionDispatch::TestProcess
  include FixtureHelpers
end

FactoryBot::SyntaxRunner.class_eval do
  include ActionDispatch::TestProcess
  include FixtureHelpers
end
