require 'socket'

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

  method, path, http_version = connection.gets.split

  if method == "GET"
    if path == '/'
      response_body = 'Hello World'

      connection.write("HTTP/1.1 200 OK\r\n" +
        "Content-Length: #{response_body.length}\r\n" +
        "\r\n" +
        response_body
      )
    else
      connection.write("HTTP/1.1 404 Not Found\r\n")
    end
  end

  connection.close_write
end
