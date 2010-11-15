module Upload
  
  # Methods for talking to sips
  # This is influenced by paperclip's Geometry class

  class Sips
    
    include Upload::CommandLine
    
    
    attr_accessor :target
    attr_accessor :source
    
    def initialize(args={})
      

      # Target will typically be a Thumbnail/Preview
      # This is so we can ask it for it's target dimensions and cropping information
      @target = args[:target]
      @source = args[:source]
      
    end
    
    def target_dimensions
      get_dimensions(target.path)
    end
    
    def source_dimensions
      get_dimensions(source.path)
    end
    
    # Sips accepts jpeg not jpg as an output format
    # we want to have .jpg as our file extensions
    def format
      target.format.to_s == 'jpg' ? 'jpeg' : target.format.to_s
    end
    
    # Returns a string with the arguments for creating the desired thumbnail
    # based on arguments from the modifier (typically a thumbnail)
    # 
    # Sips Image modification functions (that we're using)
    #   -c, --cropToHeightWidth pixelsH pixelsW 
    #   -z, --resampleHeightWidth pixelsH pixelsW 
    #       --resampleWidth pixelsW   (will distort to fit)
    #       --resampleHeight pixelsH  (will distort to fit)
    #   -Z, --resampleHeightWidthMax pixelsWH (will the longer side up to the supplied value. Scales proportially)
    # 
    # Example of sips usage (from command line)
    #
    # sips [image modification functions] imagefile ... 
    #      [--out result-file-or-dir] 
    # 
    def to_s
      
      out = ['sips']
      out << resample_arguments
      out << crop_arguments
      out << format_arguments
      out << source_path
      out << " --out #{target.path}"
      
      out.join(' ')
      
    end

    
    private
    
    
    def get_dimensions(path)
      
      raise "No path supplied" if path.nil?
      
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
      
      parse result
      
      
    end
    
    
    
    # We don't want to upscale the preview when we create thumbnails
    # So we check the target dimensions against the source dimensions
    # 
    # 
    # 
    # horizontal?
    # make sure source.width is at least the length of the target.width
    
    def resample_arguments
      
      if target.horizontal? || target.square?
        
        method = '--resampleWidth'
        
        side = target.crop? ? [source.height, target.height].min : [source.height, target.width].min
      else      
        method = '--resampleHeight'
        side = target.crop? ? target.width : target.height
      end
      
      "#{method} #{side} "
      
    end

    def crop_arguments
      
      if self.target.crop?
        "--cropToHeightWidth #{target.dimensions[:height]} #{target.dimensions[:width]}"
      end
    end
    
    def format_arguments
      "-s format #{format}"
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

    def source_path
      escape_path(self.source.path)
    end
    
  end
  
end