module Mock
  class Options
    def initialize(request)
      @request = request
    end

    def call(status_line, headers, body)
      if @request.method == 'OPTIONS'
        status_line = 'HTTP/1.1 200 OK'
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
