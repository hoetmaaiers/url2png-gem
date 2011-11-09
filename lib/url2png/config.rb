module Url2png
  module Config
    
    def self.api_url protocol
      Thread.current[:url2png_url] ||= "#{ protocol }api.url2png.com"
    end

    def self.api_version
      Thread.current[:url2png_version] ||= 'v4'
    end

    # public key setter and getter
    def self.public_key= key
      raise 'Url2png error: Invalid public key!' unless key.match(/^P/)

      Thread.current[:url2png_key] ||= key
    end
    def self.public_key
      raise 'Url2png error: No public key defined!' if Thread.current[:url2png_key].nil?

      Thread.current[:url2png_key]
    end

    # shared secret setter and getter
    def self.shared_secret= secret
      raise 'Url2png error: Invalid shared secret!' unless secret.match(/^S/)

      Thread.current[:url2png_secret] ||= secret
    end
    def self.shared_secret
      raise 'Url2png error: No shared secret defined!' if Thread.current[:url2png_secret].nil?

      Thread.current[:url2png_secret]
    end
  end
end