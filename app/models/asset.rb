
# 2010-09-22
# Looks after files within the system

class Asset
  
  
  include Mongoid::Document
  include Mongoid::Timestamps

  include Upload::Common
  include Upload::Relationships

  
  field :name
  field :original_filename  # filename
  field :original_filesize, :type => Integer, :default => 0    # filesize in bytes
  
  field :preview_created_at, :type => DateTime
  
  validate :check_file
  
  
  # Callbacks
  after_create :store!
  after_create :process!


  # Why not have a name method to display the name (if set), or display the basename?
  # Because in the asset form the name will automatically be filled in with the basename
  # If we replace the file the old filename will presist. 
  # (as the filename will be prepopulated in the name field when we go to edit the asset)

  def to_s
    name.blank? ? basename : name
  end
  
  # This is where the file (from the filesystem) is assigned to the record
  # Where possible we try to assign the name and filesize of the file
  # Additional metadata will be extracted at a later date
  # 
  def file=(file)
  
    @file = file
    
    # Set the size and filename of the uploaded file
    self.original_filesize = get_filesize
    self.original_filename = get_original_filename
  
  end
  
  alias :size :original_filesize
  
  
  # Returns our original file
  # 
  # If the file is a new record and @file hasn't been set, then we have nothing to give them
  # Otherwise we will return the file (which is the original)
  #
  def file
    @file ||= new_record? ? nil : File.new(path, 'r')
  end
  
  # Return boolean as to weither we have a file
  def file?
    !!file
  end


  # Typically 'process!' will be called outside outside 
  # of the request responce cycle eg: via delayed job
  def process!
    
    # Create thumbnails if we can create a preview
    self.thumbnails.create if self.preview.create
    
  end



  def cache_key
    
    { :id => id,
      :size => size,
      :basename => basename }
  end

  private
  
  def get_original_filename
    
    # If file hasn't been set return nil
    return nil unless file?
    
    @file.respond_to?(:original_filename) ? @file.original_filename : File.basename(@file.path)
  end

  def get_filesize
    
    # We need to have a file to get the size of the file
    return unless file?

    File.size(file.path) 

  end

  def ok_to_process?
    valid?
  end

  # Check to see if we have a file asssigned (which is a requirement)
  # and check that the file isn't zero bytes
  def check_file


    # Don't do anything unless the file has changed
    
    if file? or file_has_changed?
    
      # We can only process files (objects that respond to path)
      #
      # 2010-10-25
      # Raise a nasty error if our file object doesn't respond to path
      raise "Wasn't passed an object that responds to path" unless file.respond_to? :path

      # Add errors if the file is empty
      errors.add(:file, 'was zero bytes') if File.size(file).zero?
      
    else
      # Add error if there is no file
      errors.add(:file, 'You need to upload a file') if new_record?
    end
  end
  
  # If *either* filename or size change, we consider the file to have changed
  def file_has_changed?
    original_filename_changed? or original_filesize_changed?
  end
  

  # Create our path to where we need to be stored, then move our file there
  def store!
    
    raise "Unable to store the file" unless file

    # Construct the path in the filesystem
    FileUtils.mkdir_p(File.dirname(path))
    FileUtils.mv(@file.path, path)
    FileUtils.chmod(0644, path)
    
    # Re-assign file
    self.file = File.new(path)
    
  end

end
