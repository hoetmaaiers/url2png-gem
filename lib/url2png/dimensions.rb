module Url2png::Dimensions
  
  def self.parse options
    size = options[:size] || Url2png::Config.default_size
    
    {
      :size   => size,
      :width  => options[:width]  || size.split('x')[0],
      :height => options[:height] || size.split('x')[1]
    }
  end
  
end