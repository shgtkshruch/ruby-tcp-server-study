module Mock
  class ContentLength
    def initialize(request)
      @request = request
    end

    def call(status, headers, body)
      if %w[GET HEAD].include?(@request.method)
        headers.push("Content-Length: #{body.length}")
      end

      [status, headers, body]
    end
  end
end
