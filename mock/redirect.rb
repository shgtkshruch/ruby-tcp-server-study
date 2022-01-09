# https://datatracker.ietf.org/doc/html/rfc7231#section-7.1.2

module Mock
  class Redirect
    LIST = {
      '/redirect' => 'https://example.com',
      '/google' => 'https://google.com'
    }

    def initialize(request)
      @request = request
    end

    def call(status_line, headers, body)
      if LIST.has_key?(@request.path)
        status_line = 'HTTP/1.1 307 Temporary Redirect'
        headers.push("Location: #{LIST.fetch(@request.path)}")
        body = ''
      end

      [status_line, headers, body]
    end
  end
end
