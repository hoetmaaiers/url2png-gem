module Url2png
  module Helpers
    module Common
      extend self

      # ------------------
      # complete image tag


      def url2png_image_tag url, options = {}
        # parse size
        dim = Url2png::Dimensions.parse(options)

        # ensure image alt 
        alt = options.key?(:alt) ? options.delete(:alt) : url

        # build image tag
        img =  '<img'
        img << " src='#{ url2png_image_url(url, options) }'"
        img << " alt='#{ alt }'"
        img << " width='#{ dim[:width] }'" if options[:size]
        img << " height='#{ dim[:height] }'" if options[:size]
        options.each_pair do |k, v|
          img << " #{ k }=#{ v }" unless v.nil? || v == ''
        end
        img << ' />'
        img.respond_to?(:html_safe) ? img.html_safe : img # Utilize ActiveSupport if loaded
      end


      # --------------------------
      # only the url for the image
      def url2png_image_url url, options = {}
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
            # http://api.url2png.com/v6/<APIKEY>/<TOKEN>/png/?url=google.com
            ######

            # check for unavailable options
            options_alias = [:max_width, :max_height]
            options_available = [:custom_css_url, :delay, :force, :format, :fullpage, :say_cheese, :thumbnail_max_height, :thumbnail_max_width, :ttl, :unique, :user_agent, :viewport] 

            # assign alias to valid option
            options_alias.each do |key|
              if options.key?(key)
                case key
                # when :size
                #   options[:thumbnail_max_width] = options[:size].split('x')[0] if options[:thumbnail_max_width].nil?
                #   options[:thumbnail_max_height] = options[:size].split('x')[1] if options[:thumbnail_max_height].nil?
                when :max_width
                  options[:thumbnail_max_width] = options[key] if options[:thumbnail_max_width].nil?
                  options.delete(key)
                when :max_height
                  options[:thumbnail_max_height] = options[key] if options[:thumbnail_max_height].nil?
                  options.delete(key)
                end
              end
            end

            options = check_options(options, options_available)

            # add url to options query
            options[:url] = url


            query_string = options.
                sort_by {|s| s[0].to_s }. # sort query by keys for uniformity
                select {|s| s[1] }.       # skip empty options
                map {|s| s.map {|v| CGI::escape(v.to_s) }.join('=') }. # escape keys & vals
                join('&')

            # generate token
            token = Url2png.token query_string

            # set the format of the asset requested
            format = options[:format] || "png"
            "#{ Url2png.api_url }/v6/#{Url2png.api_key}/#{token}/#{format}/?#{query_string}"

          when 'v4'
            ######
            # v4 #
            # http://beta.url2png.com/v4/<APIKEY>/<TOKEN>/<VIEWPORT>-<THUMBNAIL>-<FULL>/<TARGET>
            ######

            # check for unavailable options
            options_available = [:size, :thumbnail, :browser_size, :delay, :fullscreen, :unique, :user_agent]
            options = check_options(options, options_available)

            # escape the url
            safe_url= CGI::escape(url)

            # generate token
            token = Url2png.token safe_url

            # build options portion of URL
            url_options = []

            # set thumbnail
            options[:thumbnail] ||= options[:size]

            url_options << "t#{ options[:thumbnail] }"
            url_options << "s#{ options[:browser_size] }" if options[:browser_size]
            url_options << "d#{ options[:delay] }" if options[:delay]
            url_options << "FULL" if options[:fullscreen]
            url_options_string = url_options.join('-')

            # build image url
            File.join(
              "#{Url2png.api_url}",
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

            options_available = [:fullscreen, :size]
            options = check_options(options, options_available)

            # escape the url
            safe_url= CGI::escape(url)

            # generate token
            token = Url2png.token safe_url

            # custom size or default_size
            size = options[:size] || Url2png.default_size

            # build options portion of URL
            if options[:fullscreen]
              bounds = "FULL"
            else
              bounds = size
            end

            # build image url
            File.join(
              "#{Url2png.api_url}",
              Url2png.api_version,
              Url2png.api_key,
              token,
              bounds,
              safe_url
            )
          end

        end
      end

      def check_options options, options_available

        # filter out unavailable options
        options = options.select do |key, value|
          if options_available.include? key 
            true
          else
            # size is a special option, only usable in the gem
            homepage = "https://github.com/robinhoudmeyers/url2png-gem"
            raise "#{options} \n \"#{key}\" is not a valid option \nCheck the gem homepage for information about options: #{homepage}" unless key == :size

          end
        end
      end

      # -----
      # Alias
      def site_image_tag url, options = {}
        url2png_image_tag(url, options)
      end

      def site_image_url url, options = {}
        url2png_image_url(url, options)
      end
    end
  end
end
