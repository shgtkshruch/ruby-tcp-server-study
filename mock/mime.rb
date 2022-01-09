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

    def call(status, headers, body)
      if (status == 200)
        extname = File.extname(@request.path)
        headers.push("Content-Type: #{MIME_TYPE.fetch(extname)}")
      end

      [status, headers, body]
    end
  end
end
