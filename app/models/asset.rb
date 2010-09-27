
# 2010-09-22
# Looks after files within the system

class Asset
  
  
  include Mongoid::Document
  include Upload::Common
  
  field :name, :type => String 
  field :original_filename, :type => String    # filename
  field :size, :type => Integer, :default => 0    # filesize in bytes
  
  field :preview_generated_at, :type => DateTime
  
  
  
  attr_accessor :file
  # validate :check_have_file
  validates_presence_of :file, :on => :create, :message => "needs to be uploaded"
  
  
  # Callbacks
  after_create :store!



  def to_s
    name.nil? ? _id.to_s : name
  end
  
  
  # This is where the file (from the filesystem) is assigned to the record
  def file=(file)
    
    @file = file
    
    # Set the original_filename
    self.original_filename = get_original_filename

    # Get the size of the file
    self.size = get_filesize
  end
  
  def name
    self.original_filename
  end
  
  
  def basename
    self.original_filename
  end
  

  # Typically 'process!' will be called outside outside 
  # of the request responce cycle eg: via delayed job
  def process!
    
  end



  # Create our path to where we need to be stored
  def store!
    
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
  
  def get_original_filename
    @file.respond_to?(:original_filename) ? @file.original_filename : File.basename(@file.path)
  end
  
  def get_filesize
    File.size(@file)
  end
  
  
  def check_have_file
    
    errors.add(:file, 'You need to upload a file') if @file.nil?
  end
  
  def ok_to_process?
    valid?
  end
  
end
