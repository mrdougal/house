
# This class represents the file that is produced from clipper
# When the parent asset is created there will also be a preview model available
# even though there may not be a preview actually generated
# 
# When the preview isn't available we will have a fallback to a generic thumbnail. 

class Preview
    
    
    include Upload::Common
    include Upload::CommandLine
    
    
    attr_accessor :parent
    
    delegate :thumbnails, :to => :parent 
    
    def initialize(parent)
      self.parent = parent
    end
    
    def name
      'preview'
    end
    
    def format
      :png
    end
    
    
    # This is the path that is return if the preview doesn't exist
    # 
    # 1. No attempt has been made to generate a preview 
    #    We should return an image that explains this to the user
    #    Be aware that the original asset may not yet have been indexed
    #    as so we won't be aware of the mime type of the image
    #
    # 2. We were unable to generate a preview from the original asset
    #    display a "generic" icon which attempts to match the mimetype of original asset
    # 
    def missing_path
      
      File.join( Rails.root, 'app/views/shared/rescues/no_preview.png' ).to_s
    end
    
    
    
    # Attempt to create a preview of the original asset
    #
    # We need to check that the original file exits
    # Then ask clipper to make an image of the file
    # (Please note that clipper won't always return a preview)
    # When this happens we need to mark the file as not being able to be indexed
    #
    def create
      
      # Make the directory (if doesn't already exist)
      FileUtils.mkdir_p File.dirname(path)
      
      cmd = []
      cmd << path_to_clipper.to_s
      
      # We need to escape the spaces in the parent.file.paths
      # Otherwise clipper will shit itself on files  which have spaces in their names. 
      # (or clipper will consider the parts of the filename as arguments)
      cmd << escape_path(parent.file.path)
      
      # The path to the output file
      cmd << "-o #{path}"
      
      # The size of the preview to create
      # Note that the size/dimensions of the file isn't guranteed
      # eg: if the file is 400x400px you're going to get a 400x400 preview
      #
      cmd << "-s 800 "
      cmd = cmd.join(' ')
      
      result = `#{cmd}`
      
      
      
      # if clipper failed to return a preview
      # we make a note that it failed
      
      Rails.logger.info "Shell result from clipper #{result}"
      
      # Mark that we now have a preview
      self.parent.update_attributes :preview_created_at => Time.now
      
    end
    
    alias :generate :create
    
    # Returns the time when the preview was last modified
    # returns nil if the preview hasn't been created
    def created_at
      
      exists? ? self.parent.preview_created_at : nil
      
    end
    
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
      
      cmd = ['sips']
      
      # You can chain the attributes you want to retrieve
      cmd << '--getProperty pixelWidth'
      cmd << '--getProperty pixelHeight'
      
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
      
      cmd << escape_path(path)
      
      result = self.class.send(:'`', cmd.join(' '))
      
      # Now we'll step through each line of the output from sips.
      # Example of typical output from sips...
      # 
      # /path/to/asset/preview.png
      #   pixelWidth: 565
      #   pixelHeight: 800
      # 
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
    
    private
    
    
    def path_to_clipper
      File.join Rails.root,'lib','bin','clipper'
    end

    
end