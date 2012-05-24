module Url2png
  
  # modes
  MODES = %w{production placehold dummy}
  
  
  # SETTERS
  def config c = {}
    
    # api_key
    # private_key
    # mode        (production[default] placehold dummy)
    # version     (v6[default])
    
    c.each do |key, value|
      case key
        
      when :api_key   
        @api_key = value
      when :private_key
        @token = value
      when :mode
        raise "Url2png error: Invalid mode, only #{ MODES.join(', ') } are allowed" unless MODES.include?(value.to_s)
        @mode = value
      when :version
        @version = value
      end
    end
  end
  

  # GETTERS
  def self.api_key
    raise 'Url2png error: No public key defined!' if @url2png_key.nil?
    @url2png_key
  end

  def self.private_key
    raise 'Url2png error: No shared secret defined!' if @url2png_secret.nil?
    @url2png_secret
  end

  def self.mode
    @url2png_mode ||= 'production'
  end
  
  def self.api_version
    @url2png_version ||= 'v6' #defaults on v6
  end
  
end