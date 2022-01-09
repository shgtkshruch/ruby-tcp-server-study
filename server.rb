require_relative './mock/mock'

PORT = 1234
ENDPOINT='0.0.0.0'

Mock::Tcp.new(PORT, ENDPOINT).start
