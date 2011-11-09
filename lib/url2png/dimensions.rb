module Url2png
  module Dimensions
    
    def self.parse options
      if options[:size]
        {
          :size   => size,
          :width  => size.split('x')[0],
          :height => size.split('x')[1]
        }
      else
        {
          :size   => nil,
          :width  => options[:width],
          :height => options[:height]
        }
      end
    end
    
  end
end