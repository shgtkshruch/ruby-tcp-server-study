module Mock
  class ContentLength
    def initialize(request_line)
      @request_line = request_line
    end

    def call(status_line, headers, body)
      method, path, http_version = @request_line.split

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
