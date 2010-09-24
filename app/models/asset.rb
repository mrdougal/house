
# 2010-09-22
# Looks after files within the system

class Asset
  
  
  include Mongoid::Document
  include Upload::Common
  
  field :name
  field :original_filename   # filename
  field :size  # filesize in bytes
  
  field :preview_generated_at, :type => DateTime
  
  attr_accessor :file
  
  def file=(file)
    self.file = file
  end
  
  
  def basename
    original_name
  end
  
  alias :name :basename
  
  def original_name
    'example.psd'
  end
  
  def format
    'psd'
  end
  
  alias :extension :format

  
  # This is so methods can be shared between thumbs, previews and the original
  def parent
    self
  end
  
  def preview
    @preview ||= Preview.new(self) if has_preview?
  end
  
  def has_preview?
    !!preview_generated_at
  end

  def thumbnails
    return unless has_preview?
    
    @thumbnails ||= ThumbnailSet.new(self, {
      :small  => { :size => '40x40' },
      :medium => { :size => '150x150' },
      :large  => { :size => '800x800', :format => :jpg }
    })
    
  end
  

  
  private
  
  def ok_to_process?
    valid?
  end
  
end
