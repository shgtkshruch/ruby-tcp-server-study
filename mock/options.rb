module Mock
  class Options
    def initialize(request)
      @request = request
    end

    def call(status, headers, body)
      if @request.method == 'OPTIONS'
        status = 200
        body = ''
        headers.push('Allow: OPTIONS, GET, HEAD')
      end

      [status, headers, body]
    end
  end
end
