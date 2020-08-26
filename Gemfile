source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'active_hash'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise'
gem 'devise_token_auth'
gem 'google-api-client'
gem 'ipaddress'
gem 'jbuilder', '~> 2.7'
gem 'mysql2', '>= 0.4.4'
gem 'puma', '~> 4.1'
gem 'pusher'
gem 'rack-cors'
gem 'rails', '~> 6.0.3', '>= 6.0.3.1'
gem 'rubyzip'
gem 'whenever', require: false
gem 'month'

group :production do
  gem 'unicorn', '5.5.1'
end

group :development, :test do
  gem 'awesome_print'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'faker-japanese'
  gem 'gimei'
  gem 'launchy'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'pry-stack_explorer'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'rubocop-performance', require: false

  # auto deploy
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano3-unicorn'
end

group :development do
  gem 'brakeman', require: false
  gem 'bullet'
  gem 'listen', '~> 3.2'
  gem 'rails-erd'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
