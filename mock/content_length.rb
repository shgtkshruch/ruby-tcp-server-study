module Mock
  class ContentLength
    def initialize(request)
      @request = request
    end

    def call(status_line, headers, body)
      if %w[GET HEAD].include?(@request.method)
        headers.push("Content-Length: #{body.length}")
      end

      [status_line, headers, body]
    end
  end
end
