require 'socket'

server = TCPServer.new 2000
client = server.accept

i = 0
loop do
  i += 1
  client.send "echo #{i}", 0
  puts client.recv 128
  sleep 1
end
