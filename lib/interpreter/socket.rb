require 'socket'

module Interpreter
  class Socket
    attr_reader :socket

    def initialize
      puts "Setting up Socket"
      @socket = TCPSocket.new 'localhost', 2000
    end

    def read
      buffer = ""
      while data = @socket.recv_nonblock(128)
        buffer << data
        break buffer if data.length < 128
      end
    rescue Errno::EAGAIN
      nil
    end

    def write(msg)
      @socket.send(msg, 0)
      puts "Socket writing: #{msg}"
    end
  end
end
