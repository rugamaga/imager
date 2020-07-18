require 'sinatra'

configure {
  set :server, :puma
}

class Imager < Sinatra::Base
  get '/hello' do
    return 'hello imager!'
  end

  run! if app_file == $0
end
