require_relative './content_length'
require_relative './mime'

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
        status_line = "HTTP/1.1 200 OK"
        headers = []

        status_line, headers, body = ContentLength.new(request_line).call(status_line, headers, body)
        status_line, headers, body = MIME.new(request_line).call(status_line, headers, body)

        connection.write(status_line + "\r\n" +
          "#{headers.join("\r\n")}" +
          "\r\n" +
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
