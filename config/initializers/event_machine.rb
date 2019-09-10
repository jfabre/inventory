module EM
  def self.start
      # faciliates debugging
      Thread.abort_on_exception = true
      # just spawn a thread and start it up
      Thread.new {
        EM.run do
           ws = Faye::WebSocket::Client.new('ws://localhost:8080/')
           ws.on :message do |event|
             p JSON.parse(event.data)
           end
           #AMQP.channel ||= AMQP::Channel.new(AMQP.connect(:host=> Q_SERVER, :user=> Q_USER, :pass => Q_PASS, :vhost => Q_VHOST ))
        end
      } unless defined?(Thin)
  end

  def self.die_gracefully_on_signal
    Signal.trap("INT")  { EM.stop }
    Signal.trap("TERM") { EM.stop }
  end
end

EM.start
