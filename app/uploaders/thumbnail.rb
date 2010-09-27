
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
  

end