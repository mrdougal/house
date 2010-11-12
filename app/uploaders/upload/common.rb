module Upload
  module Common
    
    
    module ClassMethods
      
    end
    
    module InstanceMethods
      
      
      # Gives the name of the file for thumbnails and previews.
      # eg: thumb.png or large.jpg
      #
      # Note that this method is different to the parent's basename
      # As that will include the orginal_filename
      def basename
        "#{name}.#{format}"
      end
      

      # BSON ObjectID Specification which is our primary key
      # A BSON ObjectID is a 12-byte value consisting of 
      # * 4-byte timestamp (seconds since epoch), 
      # * 3-byte machine id, a 2-byte process id, 
      # * 3-byte counter. 
      # 
      # Here's the schema:
      # 
      # [ 0 1 2 3 ] [ 4 5 6 ] [7 8] [ 9 10 11]
      # time         machine   pid   inc

      # Returns the id of the instance in a split path form. e.g. returns
      # 4c30/0ae9/a2d8/e1b2/4400/0002 for an id of 4c300ae9a2d8e1b244000002
      def id_partition

        val                = parent_id
        val                = (val.length < 9) ? ("%09d" % val ) : val
        val.scan(/(....)/).join("/")
      end
      
      # See if the file exists on the filesystem
      def exists?
        File.exists?(path)
      end
      
      
      # The path to our asset on the filesystem.
      # Note that the path is split along many directories. 
      # This is so that we don't have many files stored in one directory
      # which can (and will) result in many issues
      #
      # This will return a path to where the file should be
      # regardless to weither the file exists or not
      def path
        File.expand_path File.join(upload_base_path, parent_class_name, id_partition, version_dir, basename)
      end

      # A shortcut method, where we call the parent id and then to s
      # as the parent id is a BSON object and will error unless you explictly call to_s
      def parent_id
        self.parent._id.to_s
      end
      
      
      
      private
      
      # Returns the name of the parent's name. In our case this isn't really going to change
      # I've included it in here as it's effectively a shortcut, as the url and path methods both call this
      def parent_class_name
        self.parent.class.name.downcase.pluralize
      end
      
      
      def upload_base_path
        House::Application.config.upload_base_path
      end


      # Weither to store the file in the original directory.
      # Or put it in the thumbs dir
      # By placing all thumbs or alias into the thumbs dir, will simplify recreation of thumbs.
      # As you only need to rm -rf the thumbs dir when you recreate thumbs.
      # Also the thumbs dir *may* become quite crowded (if there are thumbs of video stills or snapshot of pdf pages)
      # So it feels better to remove the oringal from this potential chaos
      def version_dir
        original? ? 'original' : 'thumbs'
      end
      

      # Is this asset the original
      # Thumbnail and previews will return false
      def original?
        self.parent == self
      end

    end
    
    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end