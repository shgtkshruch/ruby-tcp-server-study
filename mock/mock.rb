require_relative './basic_auth'
require_relative './content_length'
require_relative './date'
require_relative './files'
require_relative './mime'
require_relative './head'
require_relative './options'

require_relative './request'

module Mock
  PUBLIC_DIR_PATH='./public'
  Middlewares = [
    Date,
    Files,
    ContentLength,
    MIME,
    HEAD,
    Options,
    BasicAuth
  ]

  def self.call(connection)
    request = Request.new(connection)

    status_line = ''
    headers = []
    body = ''

    Middlewares.each do |m|
      status_line, headers, body = m.new(request).call(status_line, headers, body)
    end

    # rfc2616 4.1 Message Types
    # https://datatracker.ietf.org/doc/html/rfc2616#section-4.1
    connection.write(status_line + "\r\n" +
      "#{headers.join("\r\n")}" + "\r\n" +
      "\r\n" +
      body
    )

    connection.close_write
  end
end
