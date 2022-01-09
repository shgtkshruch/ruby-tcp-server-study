module Mock
  class Server
    def initialize(connection)
      @connection = connection
    end

    def start
      request = Request.new(@connection)
      response = Response.new(request).generate
      @connection.write(response)
      @connection.close_write
    end
  end
end
