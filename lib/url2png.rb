require 'uri'
require 'digest'

require 'url2png/config'
require 'url2png/rails'
require 'url2png/dimensions'
require 'url2png/helpers/common'

if !defined? to_query
  class Hash
    def to_query
      require 'cgi' unless defined?(CGI) && defined?(CGI::escape)
      map {|k,v| [k,v].map {|p| CGI::escape(p.to_s) }.join('=') }.join('&')
    end
  end
end