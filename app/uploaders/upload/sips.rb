module Upload
  
  # Methods for talking to sips
  # This is influenced by paperclips Geometry class, which uses imagemagik
  #
  class Sips
    
    include Upload::CommandLine
    
    
    attr_accessor :height, :width, :path, :modifier
    
    def initialize(args={})
      
      @height   = args[:height]
      @width    = args[:width]
      @path     = args[:path]
      
      @modifier = args[:modifier]
      
    end
    
    
    
    def dimensions
      
      raise "No path supplied" if self.path.nil?
      
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

      cmd << escape_path(self.path)

      result = self.class.send(:'`', cmd.join(' '))
      
      parse result
      
      
    end
    
    
    
    # Now we'll step through each line of the output from sips.
    # Example of typical output from sips...
    # 
    # /path/to/asset/preview.png
    #   pixelWidth: 565
    #   pixelHeight: 800
    # 
    def parse(result)
      
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
  
end