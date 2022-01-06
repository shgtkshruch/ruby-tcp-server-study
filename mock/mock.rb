require_relative './content_length'
require_relative './files'
require_relative './mime'
require_relative './head'

module Mock
  PUBLIC_DIR_PATH='./public'
  Middlewares = [
    Files,
    ContentLength,
    MIME,
    HEAD
  ]

  def self.call(connection)
    request_line = connection.gets

    status_line = ''
    headers = []
    body = ''

    Middlewares.each do |m|
      status_line, headers, body = m.new(request_line).call(status_line, headers, body)
     end

    # rfc2616 4.1 Message Types
    # https://datatracker.ietf.org/doc/html/rfc2616#section-4.1
    connection.write(status_line + "\r\n" +
      "#{headers.join("\r\n")}" +
      "\r\n" +
      "\r\n" +
      body
    )

    connection.close_write
  end
end
