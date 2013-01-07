module Url2png
  extend self

  # modes
  MODES = %w{production placehold dummy}
  API_URL = 'http://beta.url2png.com'

  def config c = {}
    # mandatory
    self.api_key = c[:api_key]
    self.private_key = c[:private_key]

    # optional
    self.mode = c[:mode] if c[:mode]
    self.api_version = c[:api_version] if c[:api_version]
    self.api_url = c[:api_url] if c[:api_url]
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
    @mode = mode.to_s
  end

  def mode
    @mode ||= 'production' # default: production
  end

  def api_version=api_version
    @api_version = api_version || 'v6' # set default to latest open version
  end

  def api_version
    @api_version || 'v6' #default: v6
  end

  def api_url=api_url
    @api_url = api_url || API_URL
  end

  def api_url
    # reference => http://url2png.com/docs/
    # currently all versions suggest 'beta'
    @api_url || API_URL
  end

  def default_size=default_size
    @default_size = default_size || "400x400"
  end

  def default_size
    @default_size || "400x400"
  end

  def token param
    case self.api_version
    when 'v6'
      Digest::MD5.hexdigest("#{param}#{self.private_key}")
    when 'v4', 'v3'
      Digest::MD5.hexdigest("#{self.private_key}+#{param}")
    end
  end
end
