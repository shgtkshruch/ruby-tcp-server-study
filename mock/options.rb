module Mock
  class Options
    def initialize(request)
      @request= request
    end

    def call(status_line, headers, body)
      method, path, http_version = @request.line.split

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
