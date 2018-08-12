require 'bundler'
Bundler.require

Dotenv.load

require_relative '../models/client'
require_relative '../models/message'

configure do
  set :root, File.dirname(__FILE__)
  set :public_folder, 'public'
  set :views, 'views'
end

configure :development do
  set :database, { adapter: 'sqlite3', database: './db/sqlite3' }
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
