module Mock
  class MIME
    MIME_TYPE = {
      '.css'  => 'text/css',
      '.html' => 'text/html',
      '.jpg'  => 'image/jpeg',
      '.js'   => 'application/javascript',
      '.png'  => 'image/png'
    }

    def initialize(request)
      @request = request
    end

    def call(status_line, headers, body)
      method, path, http_version = @request.line.split

      if (status_line.include?('200'))
        path = path == '/' ? '/index.html' : path
        extname = File.extname(path)
        headers.push("Content-Type: #{MIME_TYPE.fetch(extname)}")
      end

      [
        status_line,
        headers,
        body
      ]
    end
  end
end
