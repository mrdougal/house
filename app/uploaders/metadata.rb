
# Effectively this class contains the results from querying spotlight
# Some of the attributes are cleaned prior to importing into the class

# require 'candle'

class Metadata

  include Mongoid::Document
  include Candle
  
  attr_accessor :path, :raw

  before_create :process_metadata


  
  def empty?
    self.raw.empty?
  end
  
  
  
  
  
  
  
  private
  



  def process_metadata
    
    self.raw = get_raw_metadata
    self.raw = clean_metadata if self.raw
    
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
    
    md = Candle::Base.new(path)
    md.indexed? ? md.metadata : nil
    
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
    
    raw.each_pair.each do |k,val|          
      raw.delete(k) if file_system_attribute?(k) or val.blank?
    end
    
  end
  
  # Does the attribute contain filesytem information?
  # (Which is considered irrelevant)
  def file_system_attribute?(val)
    !(val =~ /kMDItemFS*/).nil?        
  end
  
  def humanise_metadata
    
    out = {}
    self.raw.each_pair do |n, val|
      
      n = n.to_s.gsub('kMDItem','').gsub('FS','').underscore   
      
      out[n.to_sym] = val
    end
    
    out
    
  end
  
  
  
end