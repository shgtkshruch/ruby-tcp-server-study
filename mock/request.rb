module Mock
  class Request
    def initialize(connection)
      @connection = connection
    end

    def line
      @line ||= @connection.gets
    end

    def headers
      @headers ||= begin
        headers = []

        while line = @connection.gets
          break if line == "\r\n"
          key, value = line.strip.split(': ')
          headers.push({ key => value })
        end

        pp headers
        headers
      end
    end
  end
end
