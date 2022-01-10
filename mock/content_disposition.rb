# https://datatracker.ietf.org/doc/html/rfc2616#section-19.5.1
# https://datatracker.ietf.org/doc/html/rfc6266
# https://api.rubyonrails.org/v5.2.6/classes/ActionController/DataStreaming.html#method-i-send_data

module Mock
  class ContentDisposition
    def initialize(request)
      @request = request
    end

    def call(status, headers, body)
      if download_request?
        filename = @request.path[1..]
        headers.push("Content-Disposition: attachment; filename=#{filename}")
      end

      [status, headers, body]
    end

    private

    def download_request?
      @request.method == 'GET' && @request.query.include?('download')
    end
  end
end
