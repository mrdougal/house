require "spec_helper"


describe "Asset Thumbnails" do
  
  before(:each) do
    @asset = Factory :processed_asset, :file => get_fixture('images/example.jpg')
  end      


  shared_examples_for 'all thumbnails' do

    it "should have a parent" do
      @thumb.parent.should == @asset
    end

    it "should have a preview" do
      @thumb.preview.should == @asset.preview
    end
    
    it "should have a path" do
      @thumb.path.should_not be_nil
    end
  

    describe "path" do

      it "should not be blank" do
        @thumb.path.should_not be_blank
      end

      it "should contain the parent id_partition" do
        @thumb.path.should =~ /#{@asset.id_partition}/
      end

      it "should contain the thumbs dir" do
        @thumb.path.should =~ /thumbs/
      end
    
    end
    
  
    it "should have the same id as it's parent" do
      @thumb.parent_id.should == @asset.parent_id
    end
    
    it "should not say it's an original" do
      @thumb.should_not be_original
    end

  end  
  
  
  
  describe "small" do
    
    before(:each) do
      @thumb = Factory :thumb_small, :parent => @asset
    end
    
    it_should_behave_like 'all thumbnails'
    
    it "should have a name of small" do
      @thumb.name.should == :small
    end
    
    it "should have a basename of small.png" do
      @thumb.basename.should == 'small.png'
    end
    
    it "should have a format of png" do
      @thumb.format.should == :png
    end
    
    it "should say it's cropping" do
      @thumb.should be_crop
    end
    
    it "should have dimensions less than 50 pixel wide" do
      @thumb.dimensions[:width].should < '50'
    end
    
    it "should have dimensions less than 50 pixels high" do
      @thumb.dimensions[:height].should < '50'
    end
    
  end
  
  describe "medium" do

    before(:each) do
      @thumb = Factory :thumb_medium, :parent => @asset
    end
    
    it_should_behave_like 'all thumbnails'
    
    it "should have basename of medium.png" do
      @thumb.basename.should == 'medium.png'
    end
    
    it "should have a name of medium" do
      @thumb.name.should == :medium
    end
    
    it "should have a format of png" do
      @thumb.format.should == :png
    end

    it "should return crop false" do
      @thumb.crop.should == false
    end
    
    it "should not be cropping" do
      @thumb.should_not be_crop
    end

  end
  
  describe "large" do
    
    before(:each) do
      @thumb = Factory :thumb_large, :parent => @asset
    end
    
    it_should_behave_like 'all thumbnails'
    
    it "should have a basename of large.jpg" do
      @thumb.basename.should == 'large.jpg'
    end
    
    it "should have a name of large" do
      @thumb.name.should == :large
    end
    
    it "should have a format of jpg" do
      @thumb.format.should == :jpg
    end
    
    it "should not be cropping" do
      @thumb.should_not be_crop
    end
    
    
  end

  
  
end