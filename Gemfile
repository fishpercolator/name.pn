source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.1.3'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 6.0'
# Sprockets is still used for image assets, for now
gem 'sprockets-rails', '~> 3.5'
# Transpile JavaScript/CSS
gem 'cssbundling-rails', '~> 1.1'
gem 'jsbundling-rails', '~> 1.1'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

gem 'activeadmin', '~> 4.0.0.beta15'
gem 'active_storage_base64', '~> 3.0'
gem 'active_storage_validations', '~> 1.0'
gem 'acts_as_list', '~> 1.0'
gem 'amazing_print', '~> 1.3'
gem 'blueprinter', '~> 1.0'
gem 'cocoon', '~> 1.2'
gem 'datadog', '~> 2.2', require: 'datadog/auto_instrument'
gem 'devise', '~> 4.7'
gem 'devise-jwt', '~> 0.11.0'
gem 'figaro', '~> 1.2'
gem 'friendly_id', '~> 5.3'
gem 'gaffe', '~> 1.2'
gem 'gibbon', '~> 3.4', '>= 3.4.3'
gem 'haml', '~> 6.0'
gem 'high_voltage', '~> 4.0'
gem 'image_processing', '~> 1.11'
gem "importmap-rails", "~> 2.1"
gem "inline_svg", "~> 1.10"
gem 'meta-tags', '~> 2.13'
gem 'mini_magick', '~> 4.10'
gem 'pundit', '~> 2.1'
gem 'rails_semantic_logger', '~> 4.6'
gem 'render_async', '~> 2.1'
gem 'rswag-api', '~> 2.4'
gem 'rswag-ui', '~> 2.4'
gem 'simple_form', '~> 5.0'
gem 'spicy-proton', '~> 2.1'
gem 'wicked', '~> 2.0'

# gems for buttondown - eventually move this to its own gem
gem 'faraday', '~> 2.7'
gem 'addressable', '~> 2.8'

group :development, :test do
  gem 'factory_bot_rails'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'binding_of_caller'
  gem 'rspec-rails'
  gem 'rspec'
  gem 'rswag-specs', '~> 2.4'
  gem 'bundler-audit'
  gem 'spinach-rails'
  gem 'spinach'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen'
  gem 'better_errors'
  gem 'foreman'
  gem 'haml-rails'
end

group :test do
  gem 'database_cleaner'
  gem 'cuprite'
  gem 'capybara-screenshot'
  gem 'rspec-collection_matchers'
  gem 'pundit-matchers'
  gem 'timecop'
  gem 'email_spec'
  gem 'webmock'
end

group :production do
  gem 'aws-sdk-rails', '~> 3.1'
  gem 'aws-sdk-s3', '~> 1.73'
  gem 'rails_12factor', '~> 0.0.3'
end
