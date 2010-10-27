# To create previews and thumbnails we are jumping out to the shell
# This module contains methods for pharsing input and output

module Upload
  module CommandLine
    
    
    module ClassMethods
      # currently empty
    end
    
    module InstanceMethods


      # Files supplied by users may/will have spaces, comma's 
      # and other characters that will need to be escaped 
      def escape_path(path)
        
        
        # puts "path = #{path}"
        path = path.to_s
        
        # backslashes
        path.gsub!(%r{/{2,}}, "/")
        
        # Escape spaces
        path.gsub!(/ /,'\ ')
        
        # single quotes
        # path.gsub!(/'/,"\'")
        path.gsub!(/'/,'*')
        
        # double quotes
        path.gsub!('"','\"')

        # puts "output = #{path}"
        
        path
        
      end
      
      
    end
    
    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end