module Url2png
  extend self
  
  # modes
  MODES = %w{production placehold dummy}
  
  def config c = {}
    # mandatory
    self.api_key = c[:api_key]
    self.private_key = c[:private_key]
    
    # optional
    self.mode = c[:mode] if c[:mode]
    self.api_version = c[:api_version] if c[:api_version]
  end
  
  def api_key=api_key
    @api_key=api_key
  end
  
  def api_key
    raise 'Url2png error: No public key defined!' if @api_key.nil?
    @api_key
  end
  
  def private_key=private_key
    @private_key = private_key
  end

  def private_key
    raise 'Url2png error: No private key defined!' if @private_key.nil?
    @private_key
  end
  
  def mode=mode
    raise "Url2png error: Invalid mode, only #{ MODES.join(', ') } are allowed" unless MODES.include?(mode.to_s)
    @mode = mode
  end

  def mode
    @mode ||= 'production' # default: production
  end
  
  def api_version
    @api_version ||= 'v3' #default: v3
  end
  
  def default_size
    @default_size ||= "400x400"
  end
end