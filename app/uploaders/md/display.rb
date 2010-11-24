
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
      
    end
    
    def self.included(receiver)
      receiver.send :include, InstanceMethods
    end
  end
end