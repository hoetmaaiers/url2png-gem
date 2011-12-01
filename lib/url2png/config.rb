module Url2png
  
  module Config
    
    # modes
    MODES = %w{production placehold dummy}
    
    def self.mode= mode
      raise "Url2png error: Invalid mode, only #{ MODES.join(', ') } are allowed" unless MODES.include?(mode.to_s)
      @url2png_mode ||= mode.to_s
    end
    
    def self.mode
      @url2png_mode ||= 'production'
    end
    
    # api settings
    def self.api_url protocol
      @url2png_url ||= "#{ protocol }api.url2png.com"
    end

    def self.api_version
      @url2png_version ||= 'v3'
    end

    # public key setter and getter
    def self.public_key= key
      raise 'Url2png error: Invalid public key!' unless key.match(/^P/)
      @url2png_key ||= key
    end

    def self.public_key
      raise 'Url2png error: No public key defined!' if @url2png_key.nil?
      @url2png_key
    end

    # shared secret setter and getter
    def self.shared_secret= secret
      raise 'Url2png error: Invalid shared secret!' unless secret.match(/^S/)
      @url2png_secret ||= secret
    end

    def self.shared_secret
      raise 'Url2png error: No shared secret defined!' if @url2png_secret.nil?
      @url2png_secret
    end

    # size
    def self.default_size= size
      @url2png_size ||= size
    end

    def self.default_size
      @url2png_size ||= '400x400'
    end
    
  end
  
end