require_relative '../config/environment.rb'

class Client < ActiveRecord::Base
  has_many :messages
end
