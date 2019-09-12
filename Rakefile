# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

task :websocket => :environment do
  puts '...Starting client...'
  #if defined?(Rails) && (Rails.env == 'development')
  #  Rails.logger = Logger.new(STDOUT)
  #end

  EM.run do
    Signal.trap("INT")  { EM.stop }
    Signal.trap("TERM") { EM.stop }
     ws = Faye::WebSocket::Client.new('ws://localhost:8080/')
     ws.on :message do |event|
       data = JSON.parse(event.data)
       Store.update! data
     end
  end
  puts '...Closed...'
end
