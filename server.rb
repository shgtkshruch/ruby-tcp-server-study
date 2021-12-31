require 'socket'
require_relative './mock/mock'

PORT = 1234
ENDPOINT='0.0.0.0'

server = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM)

p "Server Start Port: #{PORT}"
sockaddr = Socket.sockaddr_in(PORT, ENDPOINT)
server.bind(sockaddr)

server.listen(5)

loop do
  connection, addr_info = server.accept

  print 'Local address: '
  p connection.local_address

  print 'Remote address: '
  p connection.remote_address

  Mock.call(connection)
end
