module Url2png
  module Dimensions
    def self.parse options
      # convert tumbnail to size to ensure compatibility with older gem versions
      options[:size] ||= options[:thumbnail]
      size = (options[:size] || Url2png::Config.default_size).split('x')

      width  = nil
      height = nil
      if dimensions = options.delete(:img_dimensions)
        width  = dimensions[:width] || nil
        height = dimensions[:height] || nil
      end

      {
        :size   => size.join("x"),
        :width  => width,
        :height => height
      }
    end
  end
end
