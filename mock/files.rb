module Mock
  class Files
    PUBLIC_DIR_PATH='./public'

    def initialize(request)
      @request = request
    end

    def call(status, headers, body)
      if %w[GET HEAD].include?(@request.method)
        file_path = PUBLIC_DIR_PATH + @request.path

        if File.exist?(file_path)
          status = 200
          body = File.read(file_path)
        else
          status = 404
        end
      end

      [status, headers, body]
    end
  end
end
