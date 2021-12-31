require 'socket'

PORT = 1234
ENDPOINT='0.0.0.0'

server = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM)

sockaddr = Socket.sockaddr_in(PORT, ENDPOINT)
server.bind(sockaddr)

server.listen(5)

loop do
  p "Server Start Port: #{PORT}"
  connection, addr_info = server.accept

  print 'Local address: '
  p connection.local_address

  print 'Remote address: '
  p connection.remote_address

  response_body = 'Hello World'

  connection.write("HTTP/1.1 200 OK\r\n" +
    "Content-Length: #{response_body.length}\r\n" +
    "\r\n" +
    response_body
  )

  connection.close_write
end
