require "spec_helper"

describe "Asset Preview" do
  
  before(:each) do
    @asset = Factory :processed_asset
    @preview = @asset.preview
  end      
  

  describe "relationships" do
    
    it "should have a parent" do
      @preview.parent.should == @asset
    end

    it "should have thumbnails as the parents thumbnails" do
      @preview.thumbnails.should == @asset.thumbnails
    end
  end
  
  
  describe "properties" do
    
    it "should be a png file" do
      @preview.format.should == :png
    end
    
    
    describe "url" do
      
      it "should not be blank" do
        @preview.url.should_not be_blank
      end

      it "should contain the parent id" do
        @preview.url.should =~ /#{@asset.id}/
      end
      
      it "should contain the thumbs dir" do
        @preview.url.should =~ /thumbs/
      end
    end
    
    describe "path" do
      
      it "should not be blank" do
        @preview.path.should_not be_blank
      end

      it "should contain the parent id_partition" do
        @preview.path.should =~ /#{@asset.id_partition}/
      end
      
      it "should contain the thumbs dir" do
        @preview.path.should =~ /thumbs/
      end
    end
    
    
  end

end