# https://datatracker.ietf.org/doc/html/rfc7617

require 'base64'

module Mock
  class BasicAuth
    USER_ID = 'bob'
    PASSWORD = 'secret'
    SECRET_PATH = 'secret'

    def initialize(request)
      @request = request
    end

    def call(status, headers, body)
      if @request.path.include?(SECRET_PATH)
        if authorization? && token_valid?
          status = 200
        else
          status = 401
          headers.clear.push(
            'WWW-Authenticate: Basic realm="This is secret page"'
          )
          body = ''
        end
      end

      [status, headers, body]
    end

    private

    def authorization?
      !!authorization_header
    end

    def authorization_header
      @authorization_header ||= @request.headers.find do |header|
        header.has_key?('Authorization')
      end
    end

    def token_valid?
      token = authorization_header.values.first.sub('Basic ', '')
      user_id, password = Base64.decode64(token).split(':')
      user_id == USER_ID && password == PASSWORD
    end
  end
end
