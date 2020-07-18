root = "#{Dir.getwd}"

bind "tcp://0.0.0.0:7890"
pidfile "#{root}/tmp/puma/pid"
state_path "#{root}/tmp/puma/state"
rackup "#{root}/config.ru"
threads 4, 8
activate_control_app
