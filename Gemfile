# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem "sinatra"
gem "sinatra-activerecord"
gem "rake"
gem "tux"
gem "dotenv"
gem "thin"
gem "twilio-ruby"

group :development do
  gem "pry"
  gem "sinatra-reloader"
  gem "sqlite3"
end

group :production do
  gem "pg"
end
