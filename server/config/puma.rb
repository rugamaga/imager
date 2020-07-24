root = "#{Dir.getwd}"

bind "tcp://0.0.0.0:80"
workers 3

preload_app!
rackup "#{root}/config.ru"