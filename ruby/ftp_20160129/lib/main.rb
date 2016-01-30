require 'socket'

class CustomServer
  def initialize(port)
    @port = port
  end

  def start
    server = TCPServer.new(@port)

    loop do
      Thread.new(server.accept) do |client|
        Thread.current[:dir] = `pwd`

        loop do
          request = client.gets.chomp.split(' ')
          command = request.first
          args = request[1..-1]

          reply = handle_command(command, args)
          client.puts(reply)
        end
      end
    end
  end

  def handle_command(command, args = [])
    handler = CommandHandler.get_handler(command)
    handler.call(*args)
  end
end

class CommandHandler
  COMMANDS = {
    'HELO' => -> { 'HELO' },
    'PWD' => -> { Thread.current[:dir] },
    'CD' => ->(dir) { Thread.current[:dir] = File.join(Thread.current[:dir], dir) },
  }
  INVALID_COMMAND_HANDLER = -> { 'Bad Command' }

  def self.get_handler(command)
    COMMANDS[command] || INVALID_COMMAND_HANDLER
  end
end

class CustomClient
  def connect(port)
    @socket = TCPSocket.new('localhost', port)
  end

  def send_command(command)
    @socket.puts(command)
    response = @socket.gets
    response.chomp
  end

  def disconnect
    @socket.close
  end
end