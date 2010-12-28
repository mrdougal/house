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
  
  
  describe "folder structure/heriarchy based on the mongoid" do
    
    # [ 0 1 2 3 ] [ 4 5 6 ] [7 8] [ 9 10 11]
    # time         machine   pid   inc
    
    before(:each) do
      @path = @asset.id_partition
    end
    
    it "should have 24 chars from id string" do
      @asset.id.to_s.size.should == 24
    end
    
    it "should have 4 parts" do
      @asset.id_partition.size.should == 4
    end
    
    it "should have 24 chars in total" do
      @asset.id_partition.join.size.should == 24
    end

    
    it "part 1 should have 8 characters" do
      @asset.id_partition[0].size.should == 8
    end

    it "part 2 should have 8 characters" do
      @asset.id_partition[1].size.should == 6
    end

    it "part 3 should have 4 characters" do
      @asset.id_partition[2].size.should == 4
    end

    it "part 4 should have 6 characters" do
      @asset.id_partition[3].size.should == 6
    end
    
    
  end
  
  
end