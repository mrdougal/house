require "spec_helper"

describe "Preview generation" do
  

  describe "assets that can have a preview" do
    
    can_preview.each do |val|

      describe "preview for #{val}" do
    
        it "should have a preview" do
          pending
        end

        it "should have a path " do
          pending
        end
    
        it "should have a url" do
          pending
        end
    
      end
    end
  end


  
  
  
  # Not all files will return a thumbnail
  # eg: Archives, postscript
  describe "assets that won't return a thumbnail" do
    
    [archives, 'example.ps'].flatten.each do |val|
      
      describe "preview for #{val}" do
      
        it "should say that doesn't have a preview" do
          pending
        end
      
        it "should return a default path for it's type" do
          pending
        end
      
        it "should return a default url for it's type" do
          pending
        end
      end
      
    end
  end
  
  
end