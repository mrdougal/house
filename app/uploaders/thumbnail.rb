

# This class represents the files that are produced via sips

class Thumbnail
  
  include Upload::Common
  
  
  attr_accessor :parent
  attr_accessor :config

  attr_accessor :name
  attr_accessor :size
  attr_accessor :format
  
  delegate :preview, :to => :parent 
  delegate :id,      :to => :parent 
  delegate :id_partition, :to => :parent 
  
  
  def initialize(parent, name, config)
    @parent = parent
    @name   = name
    @config = config
    
    @format = config[:format]   
    @format = :png if @format.nil?
  end
  

  
  
  
  
end