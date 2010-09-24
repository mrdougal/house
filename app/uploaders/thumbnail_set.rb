class ThumbnailSet
  
  attr_accessor :parent
  # attr_accessor :thumbs
  
  def initialize(parent, args)

    self.parent = parent
    # self.thumbs = {}
    
    args.each do |key, value|
      assign_thumbnail key, value
    end
  end
  
  def thumbs
    @thumbs ||= {}
  end
  
  
  private
  
  def assign_thumbnail(key, options)

    self.thumbs[key] = Thumbnail.new(self.parent, key, options)
    
    class_eval <<-RUBY
      def #{key}
        self.thumbs[:#{key}]
      end
    RUBY
    
  end

  # Pass everything onto the thumbs, as this class is just a wrapper
  def method_missing(name, *args, &block)
    self.thumbs.send(name, *args, &block)
  end
  

end
