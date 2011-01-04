# encoding: UTF-8

# 2010-09-27
# Dougal
# We are moving these methods out into a module so that the asset class only contain more "high level" methods

module Upload
  module Relationships
    
    module ClassMethods
      
    end
    
    module InstanceMethods
      
      
      # The original name of the asset
      # We are using this method name, as the thumbnail and preview classes share 
      # the same url and path generation methods. (these are defined in common.rb)
      def basename
        self.original_filename
      end
      
      # Preview and Thumbnails have a parent class => (the orginal)
      # This is so methods can be shared between thumbs, previews and the original
      def parent
        self
      end


      # Definition of the relationship from the preview to this class
      # TODO : This can be fixed up with an Association Proxy (like what rails uses)
      def preview
        @preview ||= Preview.new(self) #if has_preview?
      end


      # If the preview has been generated we can then attempt to create thumbnails
      # Otherwise we will get errors in trying to generate thumbnails from a file
      # that doesn't exist
      def preview?
        
        self.preview ? File.exists?(self.preview.path) : false
      end


      # Definition of the relationship between this class and thumbnails
      # TODO : This can be fixed up with an Association Proxy (like what rails uses)
      def thumbnails

        @thumbnails ||= ThumbnailSet.new(self, {
          :small  => { :dimensions => { :width  => '40', 
                                        :height => '40' }, :crop => true },
          :medium => { :dimensions => { :width  => '150',
                                        :height => '150' }},
          :large  => { :dimensions => { :width  => '800',
                                        :height => '800'}, :format => :jpg }
        })

      end


    end
    
    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end