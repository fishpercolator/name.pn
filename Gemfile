source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

gem 'activeadmin', '~> 2.6'
gem 'activeadmin_sortable_table', '~> 1.3'
gem 'active_storage_base64', '~> 1.1'
gem 'acts_as_list', '~> 1.0'
gem 'devise', '~> 4.7'
gem 'figaro', '~> 1.2'
gem 'friendly_id', '~> 5.3'
gem 'gibbon', '~> 3.3'
gem 'haml', '~> 5.1'
gem 'high_voltage', '~> 3.1'
gem 'image_processing', '~> 1.11'
gem 'meta-tags', '~> 2.13'
gem 'mini_magick', '~> 4.10'
gem 'activerecord-pg_enum', '~> 1.1'
gem 'pundit', '~> 2.1'
gem 'serviceworker-rails', '~> 0.6.0'
gem 'simple_form', '~> 5.0'
gem 'spicy-proton', '~> 2.1'
gem 'wicked', '~> 1.3'

group :development, :test do
  gem 'factory_bot_rails'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'binding_of_caller'
  gem 'rspec-rails'
  gem 'rspec'
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
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'spring-commands-rspec'
  gem 'better_errors'
  gem 'foreman'
  gem 'haml-rails'
end

group :test do
  gem 'database_cleaner'
  gem 'spring-commands-spinach'
  gem 'cuprite'
  gem 'capybara-screenshot'
  gem 'rspec-collection_matchers'
  gem 'pundit-matchers'
  gem 'timecop'
  gem 'email_spec'
end

group :production do
  gem 'aws-sdk-rails', '~> 3.1'
  gem 'aws-sdk-s3', '~> 1.73'
  gem 'rails_12factor', '~> 0.0.3'
end
