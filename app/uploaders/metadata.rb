
# Effectively this class contains the results from querying spotlight
# Some of the attributes are cleaned prior to importing into the class

# require 'candle'

class Metadata

  include Candle
  include Mongoid::Document
  include MD::Extraction
  
  embedded_in :asset, :inverse_of => :metadata
  
  before_create :extract


  
  
  # Method to see if we have any metadata
  # Checks the raw hash to see if it's empty
  def empty?
    @md.nil? ? true : @md.empty?
  end
  
  private


end