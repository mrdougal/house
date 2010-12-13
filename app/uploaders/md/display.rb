# encoding: UTF-8


# MD::Display
# Methods to help with display of asset metadata
#
# Such as group common attributes together
# Eg: PDF related attributes together
#
#   PDF Version
#   Security method
#
# Quote size in human numbers eg: 150Kb
# Quote width and height of PDF documents in cm and not in points
# Quote version as PDF version
#
# Movies
# Quote length in minutes

module MD
  module Display
    
    
    module InstanceMethods
      
      # Grouping 'special attributes' together
      # * Define a list of common attributes
      # * Those that are left over are 'special' for that type of asset
      
      
      # Formats and limits attributs for display to the user
      # eg: content_type tree, isn't an attribute that would be considered useful to the user
      def humanized_attributes


        out = {}
        attributes.each do |key, value|


          next if hidden_attributes.include? key

          v = case 
              when key =~ /page_/ then "#{value} points"

              # Portrait or landscape?
              when key == 'orientation' then value.zero? ? 'landscape' : 'portrait'

              # Convert secounds into minutes hours etc
              when key =~ /seconds/ then secounds_to_words(value)

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

        %w{ display_name content_type_tree content_type _id }

      end


      def secounds_to_words(secs)

        case secs
        when 0..1
          
          # Convert into a rational number
          # So that we can display as fractions of a second
          s = secs.rationalize
          
          "#{s.numerator}/#{number_with_delimiter s.denominator} second"
        when 1..60
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
      end

      
    end
    
    def self.included(receiver)
      
      receiver.send :include, ActionView::Helpers::NumberHelper
      receiver.send :include, InstanceMethods
    end
  end
end