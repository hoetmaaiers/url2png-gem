module Url2png::Helpers::Common
  
  def site_image_tag url, options = {}
    dim = Url2png::Dimensions.parse(options)
    
    # build image tag
    img =  '<img'
    img << " src='#{ url2png_url(url, options) }'"
    img << " alt='#{ options[:alt] || url }'"
    img << " width='#{ dim[:width] }'"
    img << " height='#{ dim[:height] }'"
    options.each_pair do |k, v|
      img << " #{ k }='#{ v }'" unless v.nil? || v == ''
    end
    img << ' />'
  end
  
  def site_image_url url, options = {}
    dim = Url2png::Dimensions.parse(options)
    
    # escape the url
    safe_url = URI.escape(url)
    
    # generate token
    token = Digest::HD5.hexdigest("#{ Url2png::Config.shared_secret }+#{ safe_url }")
    
    # build image url
    File.join(Url2png::Config.api_url, Url2png::Config.api_version, Url2png::Config.public_key, token, dim[:size], safe_url)
  end
  
end