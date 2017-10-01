require_relative './config/environment'
require_relative './models/client'
require_relative './models/message'
require 'sinatra'
require 'sinatra/reloader' if development?

configure :development do
  set :database, {adapter: "sqlite3", database: "cnycn.sqlite3"}
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

get '/' do
  @clients = Client.all
  erb :index
end

post '/send' do
  account_sid = ENV['TWILIO_SID'] # Your Account SID from www.twilio.com/console
  auth_token = ENV['TWILIO_AUTH_TOKEN']   # Your Auth Token from www.twilio.com/console

  phone_number = "+1#{params['phone_number'].gsub(/[()-]/,'')}"
  @client = Client.find_or_create_by(phone_number: phone_number)
  @client.update_attributes(first_name: params['first_name'], last_name: params['last_name'])
  if @client.save
    @message = Message.new(text: params['message'], client_id: @client.id, outbound: true)
  end

  if @message.save
    begin
      @twilio = Twilio::REST::Client.new account_sid, auth_token
      message = @twilio.messages.create(
          body: params['message'],
          to: phone_number,
          from: '+13479411418')  # Replace with your Twilio number

      puts message.sid
    rescue Twilio::REST::TwilioError => e
      puts e.message
      erb :error
    end
    redirect to ("/clients/#{@client.id}")
  else
    erb :error
  end
end

get ('/clients/:client_id') do
  @client = Client.find(params[:client_id])
  @messages = @client.messages.order(created_at: :asc)

  erb :messages
end

post '/receive' do
  puts params['From']
  puts params['Body']
  @client = Client.find_by(phone_number: params['From'])
  if @client.present?
    @message = Message.create(text: params['Body'], client_id: @client.id, inbound: true)
  end
end
