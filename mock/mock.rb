require_relative './content_length'
require_relative './files'
require_relative './mime'

module Mock
  PUBLIC_DIR_PATH='./public'
  Middlewares = [
    Files,
    ContentLength,
    MIME
  ]

  def self.call(connection)
    request_line = connection.gets

    status_line = ''
    headers = []
    body = ''

    Middlewares.each do |m|
      status_line, headers, body = m.new(request_line).call(status_line, headers, body)
     end

    connection.write(status_line + "\r\n" +
      "#{headers.join("\r\n")}" +
      "\r\n" +
      "\r\n" +
      body
    )

    connection.close_write
  end
end
