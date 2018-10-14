require_relative 'app'

class MessagesController < App
  post '/send' do
    @client = Client.find_or_initialize_by(phone_number: scrubbed_number)
    @client.first_name = params['first_name'] if @client.first_name.blank?
    @client.last_name = params['last_name'] if @client.last_name.blank?

    if @client.save
      @message = Message.new(text: params['message'], client_id: @client.id, outbound: true)
    end

    if @message.save
      begin
        send_to_twilio
      rescue Twilio::REST::TwilioError => e
        puts e.message
        redirect to ('/error')
      end
      redirect to ("/clients/#{@client.id}")
    else
      redirect to ('/error')
    end
  end

  post '/receive' do
    phone_number = params['From'].gsub('+1','')
    @client = Client.find_by(phone_number: phone_number)
    if @client.present?
      @message = Message.create(text: params['Body'], client_id: @client.id, outbound: false)
    end
  end

  post '/messages/:message_id/mark_as_read' do
    message = Message.find(params[:message_id])
    message.update_attribute(:read_at, Time.now)
  end

  private

  def scrubbed_number
    # scrub out non-digit characters
    params['phone_number'].gsub(/\D/,'')
  end

  def send_to_twilio
    account_sid = ENV['TWILIO_SID'] # Your account SID from www.twilio.com/console
    auth_token = ENV['TWILIO_AUTH_TOKEN'] # Your auth Token from www.twilio.com/console

    twilio = Twilio::REST::Client.new(account_sid, auth_token)
    message = twilio.messages.create(
      body: params['message'],
      to: "+1#{@client.phone_number}",
      from: ENV['TWILIO_NUMBER'] # Your Twilio number
    )
    puts "Message sent from #{message.sid}"
  end
end