module Upload
  module Geometry
    module ClassMethods
      
    end
  
    module InstanceMethods
      
      # Returns the resulting dimensions of the preview file
      #
      # We are using sips to tell us the dimensions of the preview.
      # It would be unreliable to base the dimensions on the original asset
      # as some items won't have pixel dimensions, eg: vectors (fonts, svg)
      # or the returned preview make be smaller, such as the case with iWork docs
      # when the return preview is ~400 pixels
      #
      # example sips usage: sips --getProperty pixelWidth path/to/asset/preview.png
      def dimensions

        return unless exists?
        
        
        @dimensions ||= (
        
          # Optionally you can return all of the properties by passing in all
          # eg: --getProperty all
          # 
          # List of available properties
          # 
          # dpiHeight        float
          # dpiWidth         float
          # pixelHeight      integer (read-only)
          # pixelWidth       integer (read-only)
          # typeIdentifier   string (read-only)
          # format           string jpeg | tiff | png | gif | jp2 | pict | bmp | qtif | psd | sgi | tga
          # formatOptions    string default | [low|normal|high|best|<percent>] | [lzw|packbits]
          # space            string (read-only)
          # samplesPerPixel  integer (read-only)
          # bitsPerSample    integer (read-only)
          # creation         string (read-only)
          # make             string
          # model            string
          # software         string (read-only)
          # description      string
          # copyright        string
          # artist           string
          # profile          binary data
          # hasAlpha         boolean (read-only)

          cmd = ['sips']

          # You can chain the attributes you want to retrieve
          cmd << '--getProperty pixelWidth'
          cmd << '--getProperty pixelHeight'

          cmd << escape_path(path)

          result = self.class.send(:'`', cmd.join(' '))
          
          process_sips_properties_to_hash result

        )

      end

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
      
      # Now we'll step through each line of the output from sips.
      # Example of typical output from sips...
      # 
      # /path/to/asset/preview.png
      #   pixelWidth: 565
      #   pixelHeight: 800
      # 
      def process_sips_properties_to_hash(result)
        
        out = {}
        result.each_line do |line|

          line = line.split(':')

          # Skip unless we have an array with two item in it
          # (which is what the first line is)
          next unless line[1]

          # Convert sips output into ruby friendly hash
          # eg: pixelWidth  => :width
          #     samplesPerPixel => :samples_per_pixel

          key = line[0].strip.gsub('pixel','').underscore
          value = line[1].strip

          out[key.to_sym] = value

        end

        # Return our output
        out
        
      end
    
    end
  
    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end  
end
