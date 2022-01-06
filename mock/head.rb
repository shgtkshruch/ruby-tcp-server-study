module Mock
  class HEAD
    def initialize(request_line)
      @request_line = request_line
    end

    def call(status_line, headers, body)
      method, path, http_version = @request_line.split

      # https://datatracker.ietf.org/doc/html/rfc2616#section-9.4
      if method == 'HEAD'
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
