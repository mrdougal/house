require "spec_helper"


describe "ThumbnailSet" do
  
  
  before(:each) do
    
    @asset = Factory :asset
    @set = @asset.thumbnails

  end
  
  
  it "should have 3 thumbnails" do
    @set.thumbs.size.should == 3
  end
  
  describe "accessing thumbnails" do
    
    shared_examples_for 'thumbnails in set' do
      
      it "should return a thumbnail" do
        @thumb.should be_instance_of(Thumbnail)
      end
      
      it "should have it's parent as @asset" do
        @thumb.parent.should == @asset
      end
    end
    

    describe "small" do
      
      before(:each) do
        @thumb = @set.small
      end
      
      it_should_behave_like 'thumbnails in set'
      
      it "should have 'small' in it's name" do
        @thumb.name.should =~ /small/
      end
      
    end
    
    describe "medium" do
      
      before(:each) do
        @thumb = @set.medium
      end

      it_should_behave_like 'thumbnails in set'
      
      it "should have 'medium' in it's name" do
        @thumb.name.should =~ /medium/
      end
      
    end
    
    describe "large" do
      
      before(:each) do
        @thumb = @set.large
      end

      it_should_behave_like 'thumbnails in set'
      
      it "should have 'large' in it's name" do
        @thumb.name.should =~ /large/
      end
      
    end
    

  end
  
  describe "array and hash like functions (method missing)" do
    
    it "should not be empty?" do
      @set.should_not be_empty
    end
    
    it "should have a size" do
      @set.size.should_not be_zero
    end
    
  end
  
  
  describe "creating thumbnails" do
    
    it "should respond to create" do
      @set.should respond_to('create')
    end
    
    it "should respond to generate (which is an alias of create)" do
      @set.should respond_to('generate')
    end
    
    
  end
  
end