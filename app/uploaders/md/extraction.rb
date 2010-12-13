# encoding: UTF-8

# MD::Extraction
# Methods for extraction and initial cleaning of metadata

module MD
  module Extraction

    module InstanceMethods
      
      def extract
        assign_metadata if extract_metadata
      end
      
      private
      
      
      def extract_metadata

        @md = get_raw_metadata
        @md = clean_metadata if @md
      end


      def assign_metadata

        return if @md.nil?

        @md.each_pair do |key, value|
          self[key] = value
        end

      end


      # Query spotlight for the files metadata
      # If the file hasn't been indexed we'll return false
      def get_raw_metadata

        # Typical example of the content return from Spotlight.
        # Not all of this content is useful to us, and some attributes will be removed
        # 
        # {
        #   "kMDItemFSLabel"                 =>140733193388032, 
        #   "kMDItemPageHeight"              =>2.68195104565268e-314, 
        #   "kMDItemKind"                    =>"Portable Document Format (PDF)", 
        #   "kMDItemFSCreatorCode"           =>140733193388032, 
        #   "kMDItemFSFinderFlags"           =>140733193388032, 
        #   "kMDItemFSTypeCode"              =>140733193388032, 
        #   "kMDItemFSNodeCount"             =>140733193388032, 
        #   "kMDItemLastUsedDate"            =>Tue Jul 06 18:53:54 +1000 2010, 
        #   "kMDItemSecurityMethod"          =>"None", 
        #   "kMDItemPageWidth"               =>2.68424562188595e-314, 
        #   "kMDItemFSContentChangeDate"     =>Tue Jul 06 18:53:54 +1000 2010, 
        #   "kMDItemVersion"                 =>"1.4", 
        #   "kMDItemFSHasCustomIcon"         =>nil, 
        #   "kMDItemFSInvisible"             =>nil, 
        #   "kMDItemFSCreationDate"          =>Tue Jul 06 18:53:54 +1000 2010, 
        #   "kMDItemEncodingApplications"    =>["Adobe PDF Library 8.0"], 
        #   "kMDItemFSOwnerUserID"           =>501, 
        #   "kMDItemCreator"                 =>"Adobe InDesign CS3 (5.0.4)", 
        #   "kMDItemContentModificationDate" =>Tue Jul 06 18:53:54 +1000 2010, 
        #   "kMDItemFSIsStationery"          =>nil, 
        #   "kMDItemFSName"                  =>"example.pdf", 
        #   "kMDItemContentCreationDate"     =>Tue Jul 06 18:53:54 +1000 2010, 
        #   "kMDItemNumberOfPages"           =>140733193388034, 
        #   "kMDItemDisplayName"             =>"example.pdf", 
        #   "kMDItemFSIsExtensionHidden"     =>nil, 
        #   "kMDItemFSSize"                  =>249309, 
        #   "kMDItemContentType"             =>"com.adobe.pdf", 
        #   "kMDItemFSOwnerGroupID"          =>20, 
        #   "kMDItemUsedDates"               =>[Tue Jul 06 00:00:00 +1000 2010], 
        #   "kMDItemContentTypeTree"         =>["com.adobe.pdf", "public.data", "public.item", "public.composite-content", "public.content"]
        # }
        # 

        raw = Candle::Base.new(asset.path)
        raw.indexed? ? raw.metadata : nil

      end

      # We need to clean the raw_meta_meta attributes
      # Remove some of the attributes that aren't useful to us
      # As their context isn't relevant on the website or it is empty
      def clean_metadata

        remove_redundant_attributes
        humanise_metadata

      end


      # Keys that have kMDItemFS is filesystem information aren't very useful for us
      # so we'll remove them, and any attributes which are empty 
      def remove_redundant_attributes

        @md.each_pair.each do |key,val|
          @md.delete(key) if redundant_attribute?(key) or val.blank?
        end
      end

      def redundant_attribute?(key)

        return true if file_system_attribute?(key) or date_related_attribute?(key)

      end

      # Does the attribute contain filesytem information?
      # (Which is considered irrelevant)
      def file_system_attribute?(key)
        !(key =~ /kMDItemFS*/).nil?        
      end

      # Dates relating to creation and modification aren't relevant
      # (information is tied to filesystem)
      def date_related_attribute?(key)
        !(key =~ /Date/).nil?
      end

      # Loop through the array returned from Spotlight and 
      # convert the attribute names (keys) into humanised ones
      def humanise_metadata

        out = {}
        @md.each_pair do |key, val|
          out[humanise_attribute_name(key).to_sym] = val
        end

        out

      end
      
      # Humanise the attribute name returned from Spotlight
      #  eg kMDItemPageWidth become page_width
      def humanise_attribute_name(val)
        val.to_s.gsub('kMDItem','').gsub('FS','').underscore
      end


      
    end
    
    def self.included(receiver)
      receiver.send :include, InstanceMethods
    end
  end
  
end