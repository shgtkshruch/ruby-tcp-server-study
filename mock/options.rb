module Mock
  class Options
    def initialize(request_line)
      @request_line = request_line
    end

    def call(status_line, headers, body)
      method, path, http_version = @request_line.split

      if method == 'OPTIONS'
        status_line = 'HTP/1.1 200 OK'
        body = ''
        headers.push('Allow: OPTIONS, GET, HEAD')
      end

      [
        status_line,
        headers,
        body
      ]
    end
  end
end
