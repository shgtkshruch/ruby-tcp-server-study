require_relative './basic_auth'
require_relative './content_length'
require_relative './content_disposition'
require_relative './date'
require_relative './files'
require_relative './head'
require_relative './mime'
require_relative './options'
require_relative './redirect'

require_relative './tcp'
require_relative './server'
require_relative './request'
require_relative './response'

module Mock
  Middlewares = [
    Files,
    ContentLength,
    ContentDisposition,
    MIME,
    HEAD,
    Options,
    Redirect,
    BasicAuth,
    Date
  ]
end
