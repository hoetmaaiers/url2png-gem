module Url2png
  module Helpers
    module Common
      
      # Same options are as for site_image_url. Any other options provided are set as attributes of the image,
      # except for :size, which is parsed to height and width attributes 
      #
      def site_image_tag url, options = {}
        url2png_options = {}
        [:thumbnail, :browser_size, :delay, :fullscreen].each do |key|
          url2png_options[key] = options.delete(key) if options.key?(key)
        end
        
        dim = Url2png::Dimensions.parse(options)
        # build image tag
        img =  '<img'
        img << " src='#{ site_image_url(url, url2png_options) }'"
        img << " alt='#{ options[:alt] || url }'"
        img << " width='#{ dim[:width] }'" if dim[:width]
        img << " height='#{ dim[:height] }'" if dim[:height]
        options.each_pair do |k, v|
          img << " #{ k }='#{ v }'" unless v.nil? || v == ''
        end
        img << ' />'
      end      

      # The options hash can have the following provided
      # (The API's default, min and max values are provided here as a
      # documentation convenience):
      #
      # :thumbnail
      #   This is a proportion bounding box.
      #   Thumbnails will be resized to fit within this box
      #   example: :thumbnail => '500x500'
      #            :thumbnail => 'ORIGINAL'
      #   default: 'ORIGINAL'
      #
      # :browser_size
      #   Set the initial browser screen size.
      #   example: :browser_size => '1024x2500'
      #   default: '1024x768
      #   min: '200x200'
      #   max: '4000x4000'
      #
      # :delay
      #   Extra delay (in seconds) forced between page load and screenshot.
      #   example: :delay => 2
      #   min: 1
      #   max: 5
      
      # :fullscreen
      #   When true, Will attempt to capture entire document canvas
      #   Will never return screenshot smaller than "Initial Screen Size"
      #   example: :fullscreen => true
      #   default: false
      #
      def site_image_url url, options = {}
        options[:protocol] ||= 'http://'
        
        # escape the url
        safe_url = URI.escape(url)

        # generate token
        token = Digest::MD5.hexdigest("#{ Url2png::Config.shared_secret }+#{ safe_url }")
        
        # build options portion of URL
        url_opts = []
        url_opts << "t#{options[:thumbnail]}" if options[:thumbnail]
        url_opts << "s#{options[:browser_size]}" if options[:browser_size]
        url_opts << "d#{options[:delay]}" if options[:delay]
        url_opts << "FULL" if options[:fullscreen]
        url_opts_string = url_opts.join('-')
        
        # build image url
        File.join(Url2png::Config.api_url(options[:protocol]), Url2png::Config.api_version, Url2png::Config.public_key, token, url_opts_string, safe_url)
      end
      
    end
  end
end