# To create previews and thumbnails we are jumping out to the shell
# This module contains methods for pharsing input and output

module Upload
  module CommandLine
    
    
    module ClassMethods


      # Files supplied by users may/will have spaces, comma's 
      # and other characters that will need to be escaped 
      #
      # This has been pulled from the Shellwords module
      #
      # Note that a resulted string should be used unquoted and is not
      # intended for use in double quotes nor in single quotes.
      #
      def escape_path(str)

        # An empty argument will be skipped, so return empty quotes.
        return "''" if str.empty?

        str = str.dup

        # Process as a single byte sequence because not all shell
        # implementations are multibyte aware.
        str.gsub!(/([^A-Za-z0-9_\-.,:\/@\n])/n, "\\\\\\1")

        # A LF cannot be escaped with a backslash because a backslash + LF
        # combo is regarded as line continuation and simply ignored.
        str.gsub!(/\n/, "'\n'")

        return str
      end

      
      
      
    end
    
    module InstanceMethods


      def escape_path(str)
        self.class.escape_path(str)
      end

      # Runs the supplied command and checks that the exit code
      # matches what's expected. Otherwise it will raise an exception
      # Logs the command that is run
      # 
      # This code is heavily inspired from thoughtbots paperclip
      def run(command, *params)
        
        Rails.logger.info "Shell command #{cmd}"
        
        
      end
      
    end
    
    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end