require_relative '../config/environment.rb'

class Message < ActiveRecord::Base
  belongs_to :client

  def direction
    outbound ? "Outbound" : "Inbound"
  end
end
