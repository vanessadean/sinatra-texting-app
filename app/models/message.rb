require 'sinatra/activerecord'

class Message < ActiveRecord::Base
  belongs_to :client
  validates :text, :client_id, presence: true

  def sender
    outbound ? 'App' : client.first_name
  end

  def styled_time
    dst_created_at.in_time_zone(ENV['TIME_ZONE']).strftime('%l:%M %P')
  end

  def styled_date
    dst_created_at.in_time_zone(ENV['TIME_ZONE']).strftime('%B %-d, %Y')
  end

  private

  def dst_created_at
    Time.now.dst? ? created_at + 1.hour : created_at
  end
end
