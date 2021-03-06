# https://datatracker.ietf.org/doc/html/rfc2616#section-9.4

module Mock
  class HEAD
    def initialize(request)
      @request = request
    end

    def call(status, headers, body)
      if @request.method == 'HEAD'
        status = 200
        body = ''
      end

      [status, headers, body]
    end
  end
end
