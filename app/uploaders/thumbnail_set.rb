class ThumbnailSet
  
  attr_accessor :parent
  
  def initialize(parent, args)

    self.parent = parent
    
    args.each do |key, value|
      assign_thumbnail key, value
    end
  end
  
  def thumbs
    @thumbs ||= {}
  end

  # Loop through the thumbnails and ask them to create their thumbnails
  def create

    return unless parent.preview.exists?

    self.thumbs.each_pair do |name, thumb|
      thumb.create
    end
  end
  
  alias :generate :create
  
  
  private
  
  def assign_thumbnail(key, options)

    self.thumbs[key] = Thumbnail.new( :parent => self.parent, :name => key, :config => options )
    
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
