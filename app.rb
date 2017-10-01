require 'dotenv'
Dotenv.load

require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'twilio-ruby'

get '/' do
  erb :index
end

post '/send' do
  account_sid = ENV['TWILIO_SID'] # Your Account SID from www.twilio.com/console
  auth_token = ENV['TWILIO_AUTH_TOKEN']   # Your Auth Token from www.twilio.com/console

  begin
    @client = Twilio::REST::Client.new account_sid, auth_token
    message = @client.messages.create(
        body: params['message'],
        to: "+1#{params['phone_number']}",
        from: '+13479411418')  # Replace with your Twilio number

    puts message.sid
  rescue Twilio::REST::TwilioError => e
    puts e.message
  end
end

post '/receive' do
  puts params['From']
  puts params['Body']
end
