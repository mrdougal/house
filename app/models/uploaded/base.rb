module Uploaded

  class Base
    
    include Mongoid::Document
    
    
    attr_accessor :file

    def initialize(file)
      self.file = file
    end
    
    
    def preview
      Preview.new(self)
    end
    
    def basename
      'example.psd'
    end
    
    
  end
  

  class Preview
    
    attr_accessor :parent
    
    
    def initialize(parent)
      self.parent = parent
    end
    
    def url
      "/something/#{name}"
    end
    
    def path
      File.join(Rails.root, 'assets', name)
    end
    
    def name
      parent.basename + '_preview.png'  
    end
    
    
    # We will ask the utility 'clipper' to render a preview of the parent file
    # Based on the result of clipper we will say if there is a thumbnail to view
    def create
      # parent.file.path
    end
    
    
  end
  
end