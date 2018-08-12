require_relative '../../config/environment'

class App < Sinatra::Application
  helpers do
    def protected!
      return if authorized?
      headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
      halt 401, 'Not authorized\n'
    end

    def authorized?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? && @auth.basic? && @auth.credentials &&
      @auth.credentials == [ENV['AUTH_USERNAME'], ENV['AUTH_PASSWORD']]
    end
  end

  get '/' do
    protected!
    @clients = Client.all.order(last_name: :asc)
    erb :index
  end

  get '/error' do
    erb :error
  end
end
