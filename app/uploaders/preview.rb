
# This class represents the file that is produced from clipper
# When the parent asset is created there will also be a preview model available
# even though there may not be a preview actually generated
# 
# When the preview isn't available we will have a fallback to a generic thumbnail. 

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
    
    
    # This is the path that is return if the preview doesn't exist
    # 
    # 1. No attempt has been made to generate a preview 
    #    We should return an image that explains this to the user
    #    Be aware that the original asset may not yet have been indexed
    #    as so we won't be aware of the mime type of the image
    #
    # 2. We were unable to generate a preview from the original asset
    #    display a "generic" icon which attempts to match the mimetype of original asset
    # 
    def missing_path
      
      File.join( Rails.root, 'app/views/shared/rescues/no_preview.png' ).to_s
    end
    
    # Attempt to create a preview of the original asset
    #
    # We need to check that the original file exits
    # Then ask clipper to make an image of the file
    # (Please note that clipper won't always return a preview)
    # When this happens we need to mark the file as not being able to be indexed
    #
    def create
      
      # Make the directory (if doesn't already exist)
      FileUtils.mkdir_p File.dirname(path)
      
      cmd = []
      cmd << path_to_clipper.to_s
      
      # Note that the path is in single quotes
      # Otherwise clipper will shit itself on files  which have spaces in their names. 
      # (or clipper will consider the parts of the filename as arguments)
      cmd << "'#{parent.file.path}'" 
      
      # The path to the output file
      cmd << "-o #{path}"
      
      # The size of the preview to create
      # Note that the size/dimensions of the file isn't guranteed
      # eg: if the file is 400x400px you're going to get a 400x400 preview
      #
      cmd << "-s 800 "
      cmd = cmd.join(' ')
      
      Rails.logger.info "Shell command #{cmd}"
      
      result = `#{cmd}`
      
      
      
      # if clipper failed to return a preview
      # we make a note that it failed
      
      Rails.logger.info "Shell result from clipper #{result}"
      
    end
    
    private
    
    
    def path_to_clipper
      File.join Rails.root,'lib','bin','clipper'
    end

    
end