module Upload
  module Geometry
    module ClassMethods
      
    end
  
    module InstanceMethods
      
      def height
        dimensions[:height].to_i        
      end
      
      def width
        dimensions[:width].to_i  
      end

      # True if the dimensions represent a square
      def square?
        height == width
      end

      # True if the dimensions represent a horizontal rectangle
      def horizontal?
        height < width
      end
      
      # True if the dimensions represent a vertical rectangle
      def vertical?
        height > width
      end
      
      # The aspect ratio of the dimensions.
      def aspect
        width.to_f / height.to_f
      end

      # Returns the larger of the two dimensions
      def larger
        [height, width].max
      end

      # Returns the smaller of the two dimensions
      def smaller
        [height, width].min
      end
      
      
      
      private
      
      
      # Returns the resulting dimensions of the preview file
      #
      # It would be unreliable to base the dimensions on the original asset
      # as some items won't have pixel dimensions, eg: vectors (fonts, svg)
      # or the returned preview make be smaller, such as the case with iWork docs
      # when the return preview is ~400 pixels
      #
      # We are using sips to tell us the dimensions of the preview file.
      # Consiquently this is an expensive call to make. 
      # (Which is why we've made it a private method)
      # 
      # example sips usage: sips --getProperty pixelWidth path/to/asset/preview.png
      def dimensions

        return unless exists?
        
        @dimensions ||= Sips.new( :path => path ).dimensions

      end
      
      

    end
  
    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end  
end
