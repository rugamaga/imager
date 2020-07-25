require 'sinatra/base'

class Imager < Sinatra::Base
  get '/api/healthcheck' do
    '{"status":"ok"}'
  end

  get '/api/hello' do
    'hello imager!'
  end

  run! if app_file == $0
end
