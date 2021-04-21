source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise', '~> 4.7', '>= 4.7.3'
gem "devise_invitable", "~> 2.0"
gem 'devise_masquerade', '~> 1.3', '>= 1.3.6'
gem 'hotwire-rails', '~> 0.1.3'
gem 'image_processing', '~> 1.2'
gem 'jbuilder', '~> 2.7'
gem 'nokogiri', '~> 1.11', '>= 1.11.1', platforms: %i[mingw mswin x64_mingw jruby]
gem 'pco_api', '~> 2.0'
gem 'pg', '~> 1.2', '>= 1.2.3'
gem 'puma', '5.2.1'
gem 'rails', '~> 6.1', '>= 6.1.3.1'
gem 'sass-rails', '>= 6'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'webpacker', '~> 5.0'
gem 'will_paginate', '~> 3.3'

group :development, :test do
  gem 'annotate', '~> 3.1', '>= 3.1.1'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails', require: 'dotenv/rails-now', groups: %i[development test]
  gem 'guard-minitest', '~> 2.4', '>= 2.4.6'
  gem 'guard-rubocop', '~> 1.4', require: false
  gem 'rubocop', '~> 1.10'
  gem 'rubocop-packaging', require: false
  gem 'rubocop-performance', '~> 1.9', '>= 1.9.2', require: false
  gem 'rubocop-rails', require: false
end

group :development do
  gem 'hirb', '~> 0.7.3'
  gem 'listen', '~> 3.3'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'faker', '~> 2.17'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
