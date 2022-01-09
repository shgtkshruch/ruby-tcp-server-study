module Mock
  class Server
    def initialize(connection)
      @connection = connection
      @status_line = ''
      @headers = []
      @body = ''
    end

    def start
      request = Request.new(@connection)

      Middlewares.each do |m|
        @status_line, @headers, @body = m.new(request).call(@status_line, @headers, @body)
      end

      build_response
      close_connection
    end

    def build_response
      # rfc2616 4.1 Message Types
      # https://datatracker.ietf.org/doc/html/rfc2616#section-4.1
      @connection.write(@status_line + "\r\n" +
        "#{@headers.join("\r\n")}" + "\r\n" +
        "\r\n" +
        @body
      )
    end

    def close_connection
      @connection.close_write
    end
  end
end
