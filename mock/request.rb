module Mock
  class Request
    def initialize(connection)
      @connection = connection
    end

    def method
      @method ||= line.split[0]
    end

    def path
      path = line.split[1]
      @path ||= path == '/' ? '/index.html' : path
    end

    def http_version
      @http_version ||= line.split[2]
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

    private

    def line
      @line ||= @connection.gets
    end
  end
end
