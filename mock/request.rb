module Mock
  class Request
    attr_reader :line, :headers

    def initialize(connection)
      @connection = connection
      @line = connection.gets
      @headers = _headers
    end

    private

    def _headers
      headers = []

      while line = @connection.gets
        break if line == "\r\n"
        key, value = line.strip.split(': ')
        headers.push({ key => value })
      end

      p headers
      headers
    end
  end
end
