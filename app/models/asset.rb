
# 2010-09-22
# Looks after files within the system

class Asset
  
  
  include Mongoid::Document
  include Upload::Common
  include Upload::Relationships
  
  
  field :name
  field :original_filename                        # filename
  field :size, :type => Integer, :default => 0    # filesize in bytes
  
  field :preview_generated_at, :type => DateTime
  
  
  
  attr_accessor :file
  validate :check_have_file
  
  
  # Callbacks
  after_create :store!



  def to_s
    name.nil? ? _id.to_s : name
  end
  

  def name
    @name || basename
  end
  
  # This is where the file (from the filesystem) is assigned to the record
  # Where possible we try to assign the name and filesize of the file
  # Additional metadata will be extracted at a later date
  # 
  def file=(file)

    @file = file

    # Set the original_filename
    self.original_filename = get_original_filename

    # Get the size of the file
    self.size = get_filesize
  end


  # Typically 'process!' will be called outside outside 
  # of the request responce cycle eg: via delayed job
  def process!
    
  end


  private
  
  
  def get_original_filename
    @file.respond_to?(:original_filename) ? @file.original_filename : File.basename(@file.path)
  end

  def get_filesize
    File.size(@file)
  end

  def ok_to_process?
    valid?
  end

  def check_have_file

    if @file.nil?
      errors.add(:file, 'You need to upload a file')
    end
  end
  

  # Create our path to where we need to be stored, then moves our object there
  def store!
    
    # # Construct the path in the filesystem
    # FileUtils.mkdir_p(File.dirname(path))
    # FileUtils.mv(file.path, path)
    # FileUtils.chmod(0644, path)
    
  end

end
