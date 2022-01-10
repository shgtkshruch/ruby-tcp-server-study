module Mock
  class Response
    HTTP_STATUS_CODES = {
      100 => 'Continue',
      101 => 'Switching Protocols',
      102 => 'Processing',
      103 => 'Early Hints',
      200 => 'OK',
      201 => 'Created',
      202 => 'Accepted',
      203 => 'Non-Authoritative Information',
      204 => 'No Content',
      205 => 'Reset Content',
      206 => 'Partial Content',
      207 => 'Multi-Status',
      208 => 'Already Reported',
      226 => 'IM Used',
      300 => 'Multiple Choices',
      301 => 'Moved Permanently',
      302 => 'Found',
      303 => 'See Other',
      304 => 'Not Modified',
      305 => 'Use Proxy',
      306 => '(Unused)',
      307 => 'Temporary Redirect',
      308 => 'Permanent Redirect',
      400 => 'Bad Request',
      401 => 'Unauthorized',
      402 => 'Payment Required',
      403 => 'Forbidden',
      404 => 'Not Found',
      405 => 'Method Not Allowed',
      406 => 'Not Acceptable',
      407 => 'Proxy Authentication Required',
      408 => 'Request Timeout',
      409 => 'Conflict',
      410 => 'Gone',
      411 => 'Length Required',
      412 => 'Precondition Failed',
      413 => 'Payload Too Large',
      414 => 'URI Too Long',
      415 => 'Unsupported Media Type',
      416 => 'Range Not Satisfiable',
      417 => 'Expectation Failed',
      421 => 'Misdirected Request',
      422 => 'Unprocessable Entity',
      423 => 'Locked',
      424 => 'Failed Dependency',
      425 => 'Too Early',
      426 => 'Upgrade Required',
      428 => 'Precondition Required',
      429 => 'Too Many Requests',
      431 => 'Request Header Fields Too Large',
      451 => 'Unavailable for Legal Reasons',
      500 => 'Internal Server Error',
      501 => 'Not Implemented',
      502 => 'Bad Gateway',
      503 => 'Service Unavailable',
      504 => 'Gateway Timeout',
      505 => 'HTTP Version Not Supported',
      506 => 'Variant Also Negotiates',
      507 => 'Insufficient Storage',
      508 => 'Loop Detected',
      509 => 'Bandwidth Limit Exceeded',
      510 => 'Not Extended',
      511 => 'Network Authentication Required'
    }

    def initialize(request)
      @request = request
      @status = 0
      @headers = []
      @body = ''
    end

    def generate
      run_middleware
      build_response
    end

    private

    def run_middleware
      Middlewares.each do |m|
        @status, @headers, @body = m.new(@request).call(@status, @headers, @body)
      end
    end

    def build_response
      # https://datatracker.ietf.org/doc/html/rfc2616#section-4.1
      status_line + "\r\n" +
      "#{@headers.join("\r\n")}" + "\r\n" +
      "\r\n" +
      @body
    end

    def status_line
      "#{@request.http_version} #{@status} #{HTTP_STATUS_CODES.fetch(@status)}"
    end
  end
end
