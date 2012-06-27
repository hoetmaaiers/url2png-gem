module Url2png
  module Helpers
    module Common
      extend self
      
      # ------------------
      # complete image tag
      
      def url2png_image_tag options = {}
        # parse size
        dim = Url2png::Dimensions.parse(options)
        
        # ensure image alt 
        alt = options.key?(:alt) ? options.delete(:alt) : options[:url]
        
        # build image tag
        img =  '<img'
        img << " src='#{ site_image_url(options) }'"
        img << " alt='#{ alt }'"
        img << " width='#{ dim[:width] }'" if options[:size]
        img << " height='#{ dim[:height] }'" if options[:size]
        options.each_pair do |k, v|
          img << " #{ k }=#{ v }" unless v.nil? || v == ''
        end
        img << ' />'
        img.html_safe
      end
      
      
      def check_options options, options_available
        # filter out unavailable options
        options = options.select do |key, value|
          if options_available.include? key 
            true
          else
            # size is a special option, only usable in the gem
            warn  "\"#{key}\" is not a valid option" unless key == :size
          end
        end
      end
      
      # --------------------------
      # only the url for the image
      def site_image_url options = {}
        # parse size
        dim = Url2png::Dimensions.parse(options)
        
        case Url2png.mode
        when 'dummy'
          'data:image/png;base64,
          iVBORw0KGgoAAAANSUhEUgAAAAIAAAACCAYAAABytg0kAAADHmlDQ1BJQ0MgUHJvZmlsZQAAeAGF
          VN9r01AU/tplnbDhizpnEQk+aJFuZFN0Q5y2a1e6zVrqNrchSJumbVyaxiTtfrAH2YtvOsV38Qc+
          +QcM2YNve5INxhRh+KyIIkz2IrOemzRNJ1MDufe73/nuOSfn5F6g+XFa0xQvDxRVU0/FwvzE5BTf
          8gFeHEMr/GhNi4YWSiZHQA/Tsnnvs/MOHsZsdO5v36v+Y9WalQwR8BwgvpQ1xCLhWaBpXNR0E+DW
          ie+dMTXCzUxzWKcECR9nOG9jgeGMjSOWZjQ1QJoJwgfFQjpLuEA4mGng8w3YzoEU5CcmqZIuizyr
          RVIv5WRFsgz28B9zg/JfsKiU6Zut5xCNbZoZTtF8it4fOX1wjOYA1cE/Xxi9QbidcFg246M1fkLN
          JK4RJr3n7nRpmO1lmpdZKRIlHCS8YlSuM2xp5gsDiZrm0+30UJKwnzS/NDNZ8+PtUJUE6zHF9fZL
          RvS6vdfbkZMH4zU+pynWf0D+vff1corleZLw67QejdX0W5I6Vtvb5M2mI8PEd1E/A0hCgo4cZCjg
          kUIMYZpjxKr4TBYZIkqk0ml0VHmyONY7KJOW7RxHeMlfDrheFvVbsrj24Pue3SXXjrwVhcW3o9hR
          7bWB6bqyE5obf3VhpaNu4Te55ZsbbasLCFH+iuWxSF5lyk+CUdd1NuaQU5f8dQvPMpTuJXYSWAy6
          rPBe+CpsCk+FF8KXv9TIzt6tEcuAcSw+q55TzcbsJdJM0utkuL+K9ULGGPmQMUNanb4kTZyKOfLa
          UAsnBneC6+biXC/XB567zF3h+rkIrS5yI47CF/VFfCHwvjO+Pl+3b4hhp9u+02TrozFa67vTkbqi
          sXqUj9sn9j2OqhMZsrG+sX5WCCu0omNqSrN0TwADJW1Ol/MFk+8RhAt8iK4tiY+rYleQTysKb5kM
          XpcMSa9I2S6wO4/tA7ZT1l3maV9zOfMqcOkb/cPrLjdVBl4ZwNFzLhegM3XkCbB8XizrFdsfPJ63
          gJE722OtPW1huos+VqvbdC5bHgG7D6vVn8+q1d3n5H8LeKP8BqkjCtbCoV8yAAAACXBIWXMAAAsT
          AAALEwEAmpwYAAABbmlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPHg6eG1wbWV0YSB4bWxuczp4
          PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNC40LjAiPgogICA8cmRmOlJERiB4
          bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgog
          ICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczpkYz0i
          aHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iPgogICAgICAgICA8ZGM6c3ViamVjdD4K
          ICAgICAgICAgICAgPHJkZjpCYWcvPgogICAgICAgICA8L2RjOnN1YmplY3Q+CiAgICAgIDwvcmRm
          OkRlc2NyaXB0aW9uPgogICA8L3JkZjpSREY+CjwveDp4bXBtZXRhPgrlPw1BAAAAFElEQVQIHWM8
          fPjwfwYgYAIRIAAAMrgDTJyW2igAAAAASUVORK5CYII='.gsub(/\n/,'')
          
        when 'placehold'
          "http://placehold.it/#{ dim[:size] }"
          
        else               
          # build parameters portion of URL
          case Url2png.api_version

          when 'v6'
            ######
            # v6 #
            # http://beta.url2png.com/v6/<APIKEY>/<TOKEN>/png/?url=google.com
            ######
            
            # check for unavailable options
            options_available = [:url, :force, :fullpage, :thumbnail_max_width, :thumbnail_max_height, :viewport]
            options = check_options(options, options_available)
          
            query_string = options.
                sort_by {|s| s[0].to_s }. # sort query by keys for uniformity
                select {|s| s[1] }.       # skip empty options
                map {|s| s.map {|v| CGI::escape(v.to_s) }.join('=') }. # escape keys & vals
                join('&')
          
            # generate token
            token = Url2png.token query_string
          
          
            "http://beta.url2png.com/v6/#{Url2png.api_key}/#{token}/png/?#{query_string}"
          
          
          
          when 'v4'
            ######
            # v4 #
            # http://beta.url2png.com/v4/<APIKEY>/<TOKEN>/<VIEWPORT>-<THUMBNAIL>-<FULL>/<TARGET>
            ######
            
            # check for unavailable options
            options_available = [:url, :size, :thumbnail, :browser_size, :delay, :fullscreen]
            options = check_options(options, options_available)
            
            # escape the url
            safe_url= CGI::escape(options[:url])
            
            # generate token
            token = Url2png.token safe_url
            
            # build options portion of URL
            url_options = []
            url_options << "t#{ dim[:size] }" if dim[:size]
            url_options << "s#{ options[:browser_size] }" if options[:browser_size]
            url_options << "d#{ options[:delay] }" if options[:delay]
            url_options << "FULL" if options[:fullscreen]
            url_options_string = url_options.join('-')
            
            # build image url
            File.join(
              "http://beta.url2png.com",
              Url2png.api_version,
              Url2png.api_key,
              token,
              url_options_string,
              safe_url
            )
            
          when 'v3'
            ######
            # v3 #
            ######

            # http://api.url2png.com/v3/api_key/security_hash/bounds/url

            # escape the url
            safe_url= CGI::escape(url)

            # generate token
            token = Url2png.token safe_url

            # build options portion of URL
            bounds = "FULL" if options[:fullscreen] || Url2png.default_size
            
            # build image url
            File.join(
              "http://api.url2png.com",
              Url2png.api_version,
              Url2png.api_key,
              token,
              bounds,
              safe_url
            )
          end
        end
      end

      # -----
      # Alias
      def site_image_tag options = {}
        url2png_image_tag(options)
      end      
    end
  end
end