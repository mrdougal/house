require "spec_helper"


describe "Asset Thumbnails" do
  
  before(:each) do
    @asset = Factory :processed_asset, :file => get_fixture('images/image.jpg')
  end      


  shared_examples_for 'all thumbnails' do

    it "should have a parent" do
      @thumb.parent.should == @asset
    end

    it "should have a preview" do
      @thumb.preview.should == @asset.preview
    end
  
    describe "url" do

      it "should not be blank" do
        @thumb.url.should_not be_blank
      end

      it "should contain the parent id" do
        @thumb.url.should =~ /#{@asset.id}/
      end

      it "should contain the thumbs dir" do
        @thumb.url.should =~ /thumbs/
      end
    
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
    
    it "should have a parent_class_name" do
      @thumb.parent_class_name.should == 'assets'
    end
  
    it "should have a parent_class_name" do
      @thumb.parent_class_name.should == 'assets'
    end
  
    it "should have the same id as it's parent" do
      @thumb.id.should == @asset.id
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