source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

gem 'active_storage_validations'
gem 'bootstrap', '~> 4.3.1'
gem 'coffee-rails', '~> 4.2'
gem 'draper'
gem 'devise', '~> 4.6', '>= 4.6.2'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'mini_racer', platforms: :ruby
gem 'rails', '~> 5.2.4.2'
gem 'sqlite3'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails', '~> 3.8'
  gem 'simplecov'
  gem 'shoulda-matchers'
end

group :test do
  gem 'capybara'
  gem 'fuubar'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
