module Mock
  module MIME
    MIME_TYPE = {
      '.css'  => 'text/css',
      '.html' => 'text/html',
      '.jpg'  => 'image/jpeg',
      '.js'   => 'application/javascript',
      '.png'  => 'image/png'
    }

    def initialize(app)
      @app = app
    end

    def self.call(request_line)
      method, path, http_version =request_line.split

      path = path == '/' ? '/index.html' : path
      file_path = PUBLIC_DIR_PATH + path
      extname = File.extname(file_path)
      "Content-Type: #{MIME_TYPE.fetch(extname)}"
    end
  end
end
