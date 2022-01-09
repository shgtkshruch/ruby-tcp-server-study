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
      if (status_line.include?('200'))
        extname = File.extname(@request.path)
        headers.push("Content-Type: #{MIME_TYPE.fetch(extname)}")
      end

      [status_line, headers, body]
    end
  end
end
