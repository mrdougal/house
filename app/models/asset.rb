
# 2010-09-22
# Looks after files within the system

class Asset
  
  
  include Mongoid::Document
  include Upload::Common
  include Upload::Relationships
  
  
  field :name
  field :original_filename  # filename
  field :original_filesize, :type => Integer, :default => 0    # filesize in bytes
  
  field :preview_generated_at, :type => DateTime
  
  validate :check_file
  
  
  # Callbacks
  after_create :store!



  def to_s
    name.nil? ? _id.to_s : name
  end
  

  def name
    self[:name].blank? ?  basename : self[:name]
  end
  
  # This is where the file (from the filesystem) is assigned to the record
  # Where possible we try to assign the name and filesize of the file
  # Additional metadata will be extracted at a later date
  # 
  def file=(file)
  
    @file = file
    
    # Set the size of the file
    self.original_filesize = get_filesize

    # Set the original_filename
    self.original_filename = get_original_filename
  
  end
  
  # alias :size :original_filesize
  
  
  # Returns our original file
  # TODO move path and url methods into this object
  def file
    @file
    # return nil unless path
    # File.new(path)
  end
  
  def file?
    !!@file
  end


  # Typically 'process!' will be called outside outside 
  # of the request responce cycle eg: via delayed job
  def process!
    
  end


  private
  
  
  def get_original_filename
    
    # If file hasn't been set return nil
    return nil unless file?
    
    @file.respond_to?(:original_filename) ? @file.original_filename : File.basename(@file.path)
  end


  def get_filesize

    # We need to have a file
    return unless file?

    # get the size of the file
    File.size(file.path) 

  end

  def ok_to_process?
    valid?
  end

  # Check to see if we have a file asssigned (which is a requirement)
  # and check that the file isn't zero bytes
  def check_file
    
    if file?
      
      # Add errors if the file is empty
      errors.add(:file, 'was zero bytes') if File.size(file).zero?
      
    else
      # Add error if there is no file
      errors.add(:file, 'You need to upload a file') unless file?
    end
  end
  

  # Create our path to where we need to be stored, then move our file there
  def store!
    
    raise "Unable to store the file" unless @file
    
    # Construct the path in the filesystem
    FileUtils.mkdir_p(File.dirname(path))
    FileUtils.mv(@file.path, path)
    FileUtils.chmod(0644, path)
    
  end

end
