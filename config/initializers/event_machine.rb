module SocketClient
  def self.start
    # faciliates debugging
    #
    Thread.abort_on_exception = true
    Thread.new {
      EM.run do
         ws = Faye::WebSocket::Client.new('ws://localhost:8080/')
         ws.on :message do |event|
           data = JSON.parse(event.data)
           Store.update! data
         end
      end
    } unless defined?(Thin)
  end

  #for passenger
  def self.die_gracefully_on_signal
    Signal.trap("INT")  { EM.stop }
    Signal.trap("TERM") { EM.stop }
  end
end

if Rails.const_defined? 'Server'
  #SocketClient.start
end
