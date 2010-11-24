# encoding: UTF-8

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
  # We are checking to see if there is a content type tree
  # as all sucessful records will contain this attribute
  def empty?

    self.content_type_tree.empty?
    
    rescue Exception
      # The method doesn't exist so it must be empty
      true
  end
  
  private


end