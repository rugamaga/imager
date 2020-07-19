require 'sinatra'

configure {
  set :server, :puma
}

class Imager < Sinatra::Base
  get '/healthcheck' do
    '{"status":"ok"}'
  end

  get '/hello' do
    'hello imager!'
  end

  run! if app_file == $0
end