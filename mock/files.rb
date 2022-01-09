module Mock
  class Files
    PUBLIC_DIR_PATH='./public'

    def initialize(request)
      @request = request
    end

    def call(status_line, headers, body)
      if %w[GET HEAD].include?(@request.method)
        file_path = PUBLIC_DIR_PATH + @request.path

        if File.exist?(file_path)
          status_line = "HTTP/1.1 200 ok"
          body = File.read(file_path)
        else
          status_line = "HTTP/1.1 404 Not Found"
        end
      end

      [status_line, headers, body]
    end
  end
end
