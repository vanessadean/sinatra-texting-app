require 'dotenv'
Dotenv.load

require 'pry'
require 'twilio-ruby'
require 'sinatra/activerecord'

require_relative '../models/client'
require_relative '../models/message'
