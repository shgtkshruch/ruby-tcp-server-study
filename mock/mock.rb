require_relative './basic_auth'
require_relative './content_length'
require_relative './date'
require_relative './files'
require_relative './head'
require_relative './mime'
require_relative './options'
require_relative './redirect'

require_relative './server'
require_relative './request'

module Mock
  Middlewares = [
    Date,
    Files,
    ContentLength,
    MIME,
    HEAD,
    Options,
    Redirect,
    BasicAuth
  ]
end
