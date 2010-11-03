
# This class represents the files that are produced via sips

class Thumbnail
  
  include Upload::Common
  include Upload::CommandLine
  
  attr_accessor :parent
  attr_accessor :name
  attr_accessor :config
  attr_accessor :format
  attr_accessor :dimensions
  
  delegate :preview, :to => :parent 
  
  def initialize(parent, name, config)

    self.parent    = parent
    self.name      = name

    @config         = config
    self.dimensions = config[:dimensions]
    
    self.format     = config[:format]   
    self.format     = :png if self.format.nil?
    
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
    
    File.join( Rails.root, "app/views/shared/rescues/no_thumbnail_#{self.basename}" ).to_s
  end
  
  
  # Create a thumbnail of the preview
  # * The preview needs to exist otherwise we'll raise an error
  # * The path to the thumbnail should already exist
  # * The size and format of the resulting thumbnail is based on our config
  #
  # We are using SIPS to generate our thumbnails.
  # * SIPS is hardware accelerated
  # * We know that the 'preview' will always be in a format that SIPS can process (png or jpeg)
  # * Is installed on *all* macs (doesn't need dev tools installed)
  # 
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
  def create
    
    # Raise an error, if there is no preview of the asset
    raise "No preview from which to create a #{name} thumbnail" unless parent.preview.exists?
    
    # Make the directory (if doesn't already exist)
    FileUtils.mkdir_p File.dirname(path)
    cmd = []

    # Are we cropping?
    
    
    # Target dimensions
    # Size is stored in the config as a hash { :width => "40", :height => "40" } 
    
    
    # We need to calculate the longer side, be it width or height
    
    
    cmd << '-s format'
    cmd << sips_output_format


    cmd << '--resampleHeightWidth'
    cmd << self.dimensions[:height]
    cmd << self.dimensions[:width]
    
    
    # Path to preview file
    cmd << escape_path(parent.preview.path)
    
    # Path to our thumbnail
    cmd << '--out'
    cmd << escape_path(path)
    
    
    cmd = cmd.join(' ')
    result = `sips #{cmd}`
    
    
    Rails.logger.info "Result from sips #{result}"
    
  end
  
  def crop?
    @config[:crop].nil? ? false : @config[:crop]
  end
  
  private
  
  # Sips accepts jpeg not jpg as an output format
  # we want to have .jpg as our file extensions
  def sips_output_format
    format.to_s == 'jpg' ? 'jpeg' : format.to_s
  end

end