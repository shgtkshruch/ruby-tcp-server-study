module Mock
  class ContentLength
    def initialize(request_line)
      @request_line = request_line
    end

    def call(status_line, headers, body)
      method, path, http_version = @request_line.split
      path = path == '/' ? '/index.html' : path
      file_path = PUBLIC_DIR_PATH + path
      response_body = File.read(file_path)

      [
        status_line,
        headers.push("Content-Length: #{response_body.length}"),
        body
      ]
    end
  end
end
