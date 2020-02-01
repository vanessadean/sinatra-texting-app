# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.6.3'

gem 'sinatra'
gem 'sinatra-activerecord'
gem 'rake'
gem 'tux'
gem 'dotenv'
gem 'thin'
gem 'twilio-ruby'

group :development do
  gem 'sinatra-reloader'
end

group :test do
  gem 'rack-test'
  gem 'rspec'
end

group :development, :test do
  gem 'pry'
  gem 'sqlite3'
end

group :production do
  gem 'pg'
end
