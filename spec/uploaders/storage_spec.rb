require "spec_helper"

describe "Storage of the file" do
  
  
  before(:each) do
    @asset = Factory :asset
  end

  
  describe "creation of the file system heriachy" do
    
    describe "path" do
      
      it "should calculate the path for the file" do
        @asset.path.should_not be_blank
      end
      
      it "should have 'original' in the files path" do
        @asset.path.should =~ /original/
      end
    
    end
    
    
    it "should build the path for the file" do
      File.exist? @asset.basepath
    end
    
    it "should move the file into a it's path" do
      File.exist? @asset.path
    end
    
  end
  
  
  
end