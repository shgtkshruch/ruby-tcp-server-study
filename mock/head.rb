module Mock
  class HEAD
    def initialize(request)
      @request = request
    end

    def call(status_line, headers, body)
      # https://datatracker.ietf.org/doc/html/rfc2616#section-9.4
      if @request.method == 'HEAD'
        status_line = 'HTTP/1.1 200 OK'
        body = ''
      end

      [
        status_line,
        headers,
        body
      ]
    end
  end
end
