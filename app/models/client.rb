require 'sinatra/activerecord'

class Client < ActiveRecord::Base
  has_many :messages, dependent: :destroy

  validates :first_name, presence: true
  validates :phone_number, presence: true, format: { without: /\D/ }, length: { minimum: 10, maximum: 10 }

  def formatted_phone
    digits = phone_number.split('')
    "(#{digits[0..2].join('')}) #{digits[3..5].join('')}-#{digits[6..10].join('')}"
  end

  def unread_messages?
    messages.where(read_at: nil).count > 0
  end
end
