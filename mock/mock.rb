module Mock
  PUBLIC_DIR_PATH='./public'

  def self.call(connection)
    request_line = connection.gets

    method, path, http_version = request_line.split

    if method == "GET"
      path = path == '/' ? '/index.html' : path
      file_path = PUBLIC_DIR_PATH + path

      if File.exist?(file_path)
        response_body = File.read(file_path)
        header = MIME.call(request_line)

        connection.write("HTTP/1.1 200 OK\r\n" +
          "Content-Length: #{response_body.length}\r\n" +
          "#{header}\r\n" +
          "\r\n" +
          response_body
        )
      else
        connection.write("HTTP/1.1 404 Not Found\r\n")
      end
    end

    connection.close_write
  end
end
