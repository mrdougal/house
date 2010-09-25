module Upload
  module Common
    
    
    module ClassMethods
      
    end
    
    module InstanceMethods
      
      
      def name
        @name.to_s
      end

      def basename
        "#{name}.#{format}"
      end
      
      def extension
        format
      end
      
      def size
        100
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

        val                = id
        val                = (val.length < 9) ? ("%09d" % val ) : val
        val.scan(/(....)/).join("/")
      end
      
      def id
        parent._id.to_s
      end
      


      def path
        File.expand_path File.join(Rails.root,'uploads', parent_class_name, id_partition, version_dir, basename)
      end

      def url
        File.join '', 'uploads', parent_class_name, id, version_dir, basename
      end
      
      
      
      private
      
      
      def parent_class_name
        parent.class.name.downcase.pluralize
      end
      
      def version_dir
        original? ? 'original' : 'thumbs'
      end
      
      def original?
        parent == self
      end

    end
    
    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end