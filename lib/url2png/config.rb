module Url2png
  extend self
  
  # modes
  MODES = %w{production placehold dummy}
  
  def config c = {}
    # SET
    #   api_key
    #   private_key
    #   mode        (production[default] placehold dummy)
    #   version     (v6[default])
    
    c.each do |key, value|
      case key
        
      when :api_key   
        @api_key = value
      when :private_key
        @private_key = value
      when :mode
        raise "Url2png error: Invalid mode, only #{ MODES.join(', ') } are allowed" unless MODES.include?(value.to_s)
        @mode = value
      when :api_version
        @api_version = value
      end
    end
  end
  

  # GETTERS
  def api_key
    raise 'Url2png error: No public key defined!' if @api_key.nil?
    @api_key
  end

  def private_key
    raise 'Url2png error: No private key defined!' if @private_key.nil?
    @private_key
  end

  def mode
    @mode ||= 'production' # default: production
  end
  
  def api_version
    @api_version ||= 'v6' #default: v6
  end
  
  def default_size
    @default_size ||= "400x400"
  end
end