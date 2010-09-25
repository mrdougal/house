
# This class represents the file that is produced from clipper

class Preview
    
    
    include Upload::Common
    
    
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
    
    
    

    
end