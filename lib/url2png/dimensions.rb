
module Url2png
  module Dimensions
    def self.parse options
      # convert tumbnail to size to ensure compatibility with older gem versions
      options[:size] = options[:thumbnail] if options[:size].nil?

      size = options[:size] === false ? nil : (options[:size] || Url2png::Config.default_size).split('x')
      size = size.join("x") if size.is_a? Array

      if dimensions = options.delete(:img_dimensions)
        width  = dimensions[:width] || nil
        height = dimensions[:height] || nil
      end

      {:size => size, :width => width, :height => height}
    end
  end
end

