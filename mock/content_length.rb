module Mock
  class ContentLength
    def initialize(request_line)
      @request_line = request_line
    end

    def call(status_line, headers, body)
      method, path, http_version = @request_line.split

      [
        status_line,
        headers.push("Content-Length: #{body.length}"),
        body
      ]
    end
  end
end
