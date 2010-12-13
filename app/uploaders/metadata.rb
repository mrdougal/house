# encoding: UTF-8

# Effectively this class contains the results from querying spotlight
# Some of the attributes are cleaned prior to importing into the class

# require 'candle'

class Metadata

  include Candle
  include Mongoid::Document
  include MD::Extraction
  
  include ActionView::Helpers::NumberHelper
  # include ActionView::Helpers::TextHelper
  
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
  
  # Used in the display of attributes
  def humanized_attributes
    
    
    out = {}
    attributes.each do |key, value|
      
      
      next if hidden_attributes.include? key
      
      v = case 
          when key =~ /page_/ then "#{value} points"
            
          # Portrait or landscape?
          when key == 'orientation' then value.zero? ? 'landscape' : 'portrait'
            
          # Convert secounds into minutes hours etc
          when key =~ /duration/ then secounds_to_words(value)
          
          # Don't convert years
          when key =~ /year/ then value
            
          when key =~ /sample_rate/ then "#{number_with_delimiter value.to_i} Hz"
          when key =~ /bit_rate/ then "#{number_with_delimiter value.to_i} bps"


            
          # Break arrays into a sentence  
          when value.instance_of?(Array) then value.to_sentence

          # Display numbers with delimiters
          when (value.instance_of?(Fixnum) or value.instance_of?(Float)) then number_with_delimiter value


          else value
          end
        
      
      
      out[key.humanize] = v
    end
    
    out
    
    
  end
  
  private
  
  
  # A list of attributes that we don't need to show to the user
  def hidden_attributes

    %w{ display_name content_type_tree content_type }
    
  end
  
  
  def secounds_to_words(secs)

    case secs
    when 0..60
      pluralize secs, 'second'
    when 60..3600

      m = (secs.to_f/60).round(2)
      m = m.floor if m.floor == m
    
      pluralize m ,'minute'
    
    else
    
      m = (secs.to_f/3600).round(2)
      m = m.floor if m.floor == m
    
      pluralize m ,'hour'
    end
  end

  def pluralize(number, singular)
    "#{number} " << (number.to_i < 1 ? singular : singular.pluralize)
    # "#{count || 0} " + ((count == 1 || count =~ /^1(\.0+)?$/) ? singular : (plural || singular.pluralize))
    
  end


end