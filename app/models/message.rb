require 'sinatra/activerecord'

class Message < ActiveRecord::Base
  belongs_to :client
  validates :text, presence: true
  validates :client_id, presence: true

  def sender
    outbound ? 'App' : client.first_name
  end

  def styled_time
    time = Time.now.dst? ? created_at + 1.hour : created_at
    time.in_time_zone(ENV['TIME_ZONE']).strftime('%l:%M %P')
  end

  def date
    created_at.in_time_zone(ENV['TIME_ZONE']).strftime('%B %-d, %Y')
  end
end
