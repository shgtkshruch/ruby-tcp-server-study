require_relative './content_length'
require_relative './files'
require_relative './mime'

module Mock
  PUBLIC_DIR_PATH='./public'

  def self.call(connection)
    request_line = connection.gets

    status_line = ''
    headers = []
    body = ''

    status_line, headers, body = Files.new(request_line).call(status_line, headers, body)
    status_line, headers, body = ContentLength.new(request_line).call(status_line, headers, body)
    status_line, headers, body = MIME.new(request_line).call(status_line, headers, body)

    connection.write(status_line + "\r\n" +
      "#{headers.join("\r\n")}" +
      "\r\n" +
      "\r\n" +
      body
    )

    connection.close_write
  end
end
