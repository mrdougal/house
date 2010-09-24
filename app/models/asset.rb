
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
  validate :check_have_file
  # validates_presence_of :file, :on => :create, :message => "needs to be uploaded"
  
  
  # Callbacks
  after_create :store!




  
  
  # # This is where the file (from the filesystem) is assigned to the record
  # def file=(file)
  #   self.file = file
  # end
  
  
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



  # Typically 'process!' will be called outside outside 
  # of the request responce cycle eg: via delayed job
  #
  # Or optionally the asset may be indexed
  def process!
    
  end



  # Create our path to where we need to be stored
  def store!
    
    # @file.close
    
    # Construct the path in the filesystem
    FileUtils.mkdir_p(File.dirname(path))
    FileUtils.mv(file.path, path)
    FileUtils.chmod(0644, path)
    
  end



  
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
  
  def check_have_file
    
    errors.add(:file, 'You need to upload a file') if self.file.nil?
  end
  
  def ok_to_process?
    valid?
  end
  
end
