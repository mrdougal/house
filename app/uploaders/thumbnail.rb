
# This class represents the files that are produced via sips

class Thumbnail
  
  include Upload::Common
  
  attr_accessor :parent
  attr_accessor :name
  attr_accessor :format
  
  delegate :preview, :to => :parent 
  # delegate :id,      :to => :parent 
  
  def initialize(parent, name, config)

    self.parent = parent
    self.name   = name

    self.format = config[:format]   
    self.format = :png if self.format.nil?
    
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
  

end