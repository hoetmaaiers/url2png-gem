module Url2png
  module Helpers
    module Common

      def site_image_tag url, options = {}
        dim = Url2png::Dimensions.parse(options)

        # build image tag
        img =  '<img'
        img << " src='#{ site_image_url(url, options) }'"
        img << " alt='#{ options[:alt] || url }'"
        img << " width='#{ dim[:width] }'"
        img << " height='#{ dim[:height] }'"
        options.each_pair do |k, v|
          img << " #{ k }='#{ v }'" unless v.nil? || v == ''
        end
        img << ' />'
        img.html_safe
      end

      def site_image_url url, options = {}
        options[:protocol] ||= 'http://'
        dim = Url2png::Dimensions.parse(options)

        #ONly to be used inside rails app, obviously
        unless Rails.env.production?
          return fake_url_for_image_sized dim
        end

        # escape the url
        safe_url = URI.escape(url)

        # generate token
        token = Digest::MD5.hexdigest("#{ Url2png::Config.shared_secret }+#{ safe_url }")

        # build image url
        File.join(Url2png::Config.api_url(options[:protocol]),
                  Url2png::Config.api_version,
                  Url2png::Config.public_key,
                  token,
                  dim[:size],
                  safe_url)
      end

private

      def fake_url_for_image_sized dim
        size, width, height = dim[:size], dim[:width].to_i, dim[:height].to_i
        path = "#{Rails.root}/app/assets/images/"
        name = "u2p-#{size}.png"
        file_name = path + name

        if File.exist? file_name
          return "/assets/#{name}"
        else
          generate_image_sized width, height, path, name
        end
      end

      def generate_image_sized width, height, path, name
        require 'png'
        png = PNG.new PNG::Canvas.new width, height, PNG::Color::Black
        png.save "#{path}#{name}"
        "/assets/#{name}"
      end

    end
  end
end
