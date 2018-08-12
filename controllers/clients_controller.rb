require_relative "app"

class ClientsController < App
  get ('/clients/:client_id') do
    protected!
    @client = Client.find(params[:client_id])
    @client.messages.where(read_at: nil).update_all(read_at: Time.now)
    @messages = @client.messages.order(created_at: :asc).group_by { |m| m.date }

    erb :messages
  end

  get '/clients/:client_id/new_messages' do
    client = Client.find(params[:client_id])
    messages = client.messages.where(read_at: nil)

    { messages: messages, status: 200 }.to_json
  end
end