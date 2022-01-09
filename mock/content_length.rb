module Mock
  class ContentLength
    def initialize(request)
      @request = request
    end

    def call(status_line, headers, body)
      method, path, http_version = @request.line.split

      if %w[GET HEAD].include?(method)
        headers.push("Content-Length: #{body.length}")
      end

      [
        status_line,
        headers,
        body
      ]
    end
  end
end
