module Url2png
  module Dimensions
    
    def self.parse options
      # if Url2png.api_version == "v6"
      #   options[:size] ||= "#{options[:thumbnail_max_width]}x#{options[:thumbnail_max_height]}"
      # end
      
      # distill image size
      size   = (options[:size]  || Url2png.default_size).split('x')
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