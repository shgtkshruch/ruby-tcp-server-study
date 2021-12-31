module Mock
  class MIME
    MIME_TYPE = {
      '.css'  => 'text/css',
      '.html' => 'text/html',
      '.jpg'  => 'image/jpeg',
      '.js'   => 'application/javascript',
      '.png'  => 'image/png'
    }

    def initialize(request_line)
      @request_line = request_line
    end

    def call(status_line, headers, body)
      method, path, http_version = @request_line.split

      path = path == '/' ? '/index.html' : path
      file_path = PUBLIC_DIR_PATH + path
      extname = File.extname(file_path)

      [
        status_line,
        headers.push("Content-Type: #{MIME_TYPE.fetch(extname)}"),
        body
      ]
    end
  end
end
