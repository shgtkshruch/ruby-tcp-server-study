# https://datatracker.ietf.org/doc/html/rfc7231#section-7.1.1.2

require 'time'

module Mock
  class Date
    def initialize(request)
      @request = request
    end

    def call(status_line, headers, body)
      # https://docs.ruby-lang.org/ja/latest/method/Time/s/httpdate.html
      headers.push("Date: #{Time.now.httpdate}")

      [
        status_line,
        headers,
        body
      ]
    end
  end
end
