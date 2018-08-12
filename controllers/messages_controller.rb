require_relative 'app'

class MessagesController < App
  post '/send' do
    account_sid = ENV['TWILIO_SID'] # Your account SID from www.twilio.com/console
    auth_token = ENV['TWILIO_AUTH_TOKEN'] # Your auth Token from www.twilio.com/console

    # scrub out non-digit characters
    phone_number = "#{params['phone_number'].gsub(/\D/,'')}"

    if phone_number.length != 10
      redirect to ('/error')
    end

    @client = Client.find_or_create_by(phone_number: phone_number)
    @client.first_name = params['first_name'] if @client.first_name.blank?
    @client.last_name = params['last_name'] if @client.last_name.blank?

    if @client.save
      @message = Message.new(text: params['message'], client_id: @client.id, outbound: true)
    end

    if @message.save
      begin
        @twilio = Twilio::REST::Client.new(account_sid, auth_token)
        message = @twilio.messages.create(
          body: params['message'],
          to: "+1#{@client.phone_number}",
          from: ENV['TWILIO_NUMBER'] # Your Twilio number
        )
        puts "Message sent from #{message.sid}"
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
      @message = Message.create(text: params['Body'], client_id: @client.id, inbound: true)
    end
  end

  post '/messages/:message_id/mark_as_read' do
    message = Message.find(params[:message_id])
    message.update_attribute(:read_at, Time.now)
  end
end