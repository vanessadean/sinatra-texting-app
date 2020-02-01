require 'bundler'
Bundler.require

Dotenv.load

require_relative '../app/models/client'
require_relative '../app/models/message'

configure do
  set :root, File.dirname(__FILE__)
  set :public_folder, 'public'
  set :views, 'app/views'
  Time.zone = 'UTC'
end

configure :development do
  set :database, { adapter: 'sqlite3', database: '../db/sqlite3' }
end

configure :test do
  set :database, { adapter: 'sqlite3', database: '../db/sqlite3_test' }
end

configure :production do
 db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///localhost/database')

 ActiveRecord::Base.establish_connection(
   :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
   :host     => db.host,
   :username => db.user,
   :password => db.password,
   :database => db.path[1..-1],
   :encoding => 'utf8'
 )
end
