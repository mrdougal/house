
# Pathname represents the absolute or relative name of a file. 
require 'pathname'


module Upload
  class SanitisedFile


    attr_accessor :file

    def initialize(file)
      self.file = file
    end  
    
    # Return the santised filename
    def name
      sanitise(original_filename) if original_filename
    end
    
    # Returns the original filename without any santisation
    def original_filename
      
      return @original_filename if @original_filename
      
      if @file and @file.respond_to?(:original_filename)
        @file.original_filename

      elsif path
        # We'll use the basename of the path
        File.basename(path)
      end
    end
    

  
    # Returns the part of the filename before the extension
    # eg: return example from example.psd
    def basename
      
      split_extension(filename)[0] if filename
    end
  
  
  
  
  
  
    # Return true if the file is valid and isn't zero bytes
    def empty?
      @file.nil? || self.size.nil? || self.size.zero?
    end
  
    # Returns the size of the file
    def size
      
      if is_path?
        exists? ? File.size(path) : 0
      elsif @file.respond_to?(:size)
        @file.size
      else
        0
      end
    end

    # Returns true if the file is supplied as a string or pathname 
    def is_path?
      !((@file.is_a?(String) || @file.is_a?(Pathname)) && !@file.blank?)
    end


    # Does the file exist?
    def exists?
      return File.exists?(self.path) if self.path
      false
    end
    
    # Returns the full path to the file, otherwise will return nil
    def path
      
      unless @file.blank?
        if is_path?
          File.expand_path(@file.to_s)
        elsif @file.respond_to?(:path) and not @file.path.blank?
          
          File.expand_path(@file.path)
        end
      end
    end


  
    private
    
    
    # Sanitise the filename, to prevent hacking
    def sanitise(name)
      
      # name = name.gsub("\\", "/") # work-around for dirty IE, as it supplies the path
      # 
      # name = File.basename(name)
      # name = name.gsub(/[^a-zA-Z0-9\.\-\+_]/,"_")
      # name = "_#{name}" if name =~ /\A\.+\z/
      # name = "unnamed" if name.size == 0
      
      return name.downcase
      
    end
  
  
    def split_extension(filename)
  
      # regular expressions to try for identifying extensions
      extension_matchers = [
        /\A(.+)\.(tar\.gz)\z/, # matches "something.tar.gz"
        /\A(.+)\.([^\.]+)\z/ # matches "something.jpg"
      ]

      extension_matchers.each do |regexp|
        if filename =~ regexp
          return $1, $2
        end
      end
      return filename, "" # In case we weren't able to split the extension
    end
  
  
  
  end  
end
