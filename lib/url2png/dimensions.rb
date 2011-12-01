module Url2png
  module Dimensions
    
    def self.parse options
      # convert tumbnail to size to ensure compatibility with older gem versions
      options[:size] ||= options[:thumbnail]
      
      # distill image size
      size   = (options[:size]  || Url2png::Config.default_size).split('x')
      width  = options[:width]  || size[0]
      height = options[:height] || size[1]
      
      # return dimensions hash
      {
        :size   => "#{ width }x#{ height }",
        :width  => width,
        :height => height
      }
    end
    
  end
end