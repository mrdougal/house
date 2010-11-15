
# This class represents the files that are produced via sips

class Thumbnail
  
  include Upload::Common
  include Upload::CommandLine
  include Upload::Geometry
  
  attr_accessor :parent, :name, :config, :format, :dimensions, :crop
  attr_writer :crop
  
  delegate :preview, :to => :parent 
  
  def initialize(args={})

    self.parent     = args[:parent]
    self.name       = args[:name]
    self.config     = args[:config]

    unless self.config.nil?
      
      self.dimensions = self.config[:dimensions]
      self.format     = self.config[:format]   
      self.crop       = self.config[:crop]
    end

    self.crop       = false if self.crop.nil?
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
  def create
    
    # Raise an error, if there is no preview of the asset
    raise "No preview from which to create a #{name} thumbnail" unless parent.preview.exists?
    
    # Make the directory (if doesn't already exist)
    FileUtils.mkdir_p File.dirname(path)

    cmd = Upload::Sips.new :target => self, :source => self.preview 
    result = `#{cmd.to_s}`
    
    Rails.logger.info "Result from sips #{result}"
    
  end
  
  
  alias :save! :create

  def crop?
    self.crop == true
  end
  
  private

end