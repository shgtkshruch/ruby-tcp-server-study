module Mock
  class Files
    def initialize(request_line)
      @request_line = request_line
    end

    def call(status_line, headers, body)
      method, path, http_version = @request_line.split

      if method == "GET"
        path = path == '/' ? '/index.html' : path
        file_path = PUBLIC_DIR_PATH + path

        if File.exist?(file_path)
          status_line = "HTTP/1.1 200 ok"
          body = File.read(file_path)
        else
          status_line = "HTTP/1.1 404 Not Found"
        end

        [
          status_line,
          headers,
          body
        ]
      end
    end
  end
end
