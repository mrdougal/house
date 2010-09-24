require "spec_helper"


describe "Asset Thumbnails" do
  
  before(:each) do
    @asset = Factory :processed_asset
  end      


  shared_examples_for 'all thumbnails' do
  
    it "should have a parent" do
      @thumb.parent.should == @asset
    end

    it "should have a preview" do
      @thumb.preview.should == @asset.preview
    end
    
    
    it "should have a path underneath the parent" do
      @thumb.path.should == @thumb.parent.path
    end
    
    it "should have a url underneath the parent" do
      @thumb.url.should == @thumb.parent.url
    end
    
    it "should not say it's an original" do
      @thumb.should_not be_original
    end
    

  end  
  
  
  
  describe "small" do
    
    before(:each) do
      @thumb = @asset.thumbnails.small
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
    
    it "should be less than 50 pixel wide" do
      pending
    end
    
    it "should be less than 50 pixels high" do
      pending
    end
    
  end
  
  describe "medium" do

    before(:each) do
      @thumb = @asset.thumbnails.medium
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
    

  end
  
  describe "large" do
    
    before(:each) do
      @thumb = @asset.thumbnails.large
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
    
    
  end

  
  
end