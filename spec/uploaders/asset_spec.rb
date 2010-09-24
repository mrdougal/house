require "spec_helper"


describe "Asset" do
  
  
  shared_examples_for 'an original asset' do
    
    # Names

    it "should have a name" do
      @asset.name.should_not be_blank
    end
    
    it "should have a basename" do
      @asset.basename.should_not be_blank
    end

    it "should have an extension" do
      @asset.extension.should_not be_blank
    end
    
    
    it "should have a path" do
      @asset.path.should_not be_blank
    end
    
    it "should have a url" do
      @asset.url.should_not be_blank
    end
    
    it "should have a size" do
      @asset.size.should_not be_blank
    end
    
    it "should be an original" do
      @asset.should be_original
    end
    
  end
  
  

  describe "a processed asset" do

    before(:each) do
      @asset = Factory :processed_asset
    end      

    it_should_behave_like 'an original asset'
    
    it "should have a preview" do
      @asset.preview.should_not be_nil
    end

    it "should have thumbnails" do
      @asset.thumbnails.should_not be_empty
    end
  
  
    # describe "Preview" do
    # 
    #   before(:each) do
    #     @file = @asset.preview
    #   end
    # 
    #   it_should_behave_like 'all valid files'
    # 
    #   it "should have a parent" do
    #     @file.parent.should == @asset
    #   end
    # 
    #   it "should have thumbnails" do
    #     @file.thumbnails.should == @asset.thumbnails
    #   end
    # 
    # end
  
  end
  
  describe "a new asset" do
    
    before(:each) do
      @asset = Factory :asset
      @asset.stub(:new_record?).and_return true
    end
    
    
    it "should not have a preview" do
      @asset.preview.should be_nil
    end

    it "should not have any thumbnails" do
      @asset.thumbnails.should be_nil
    end
    
    it "should be ok to process" do
      @asset.should be_ok_to_process
    end
    
  end
  

  
  
  
  # describe "filenames" do
  #   
  #   describe "from real world file names" do
  #     it_should_behave_like 'all valid files'
  #   end
  #   
  #   describe "with complicated extensions" do
  #     it_should_behave_like 'all valid files'
  #   end
  #   
  # end
  # 
  # describe "santizing names" do
  #   
  #   it_should_behave_like 'all valid files'
  #   
  #   it "should remove illegal characters" do
  #     pending
  #   end
  #   
  #   it "should remove the path prefix (as IE does)" do
  #     pending
  #   end
  #   
  # end
  # 
  # describe "illegal files" do
  #   
  #   shared_examples_for 'invalid files' do
  #     
  #     it "shouldn't be valid" do
  #       pending
  #     end
  #   
  #     it "shouldn't have a preview" do
  #       pending
  #     end
  #   
  #     it "shouldn't have thumbnails" do
  #       pending
  #     end
  #   end
  #   
  #   
  #   describe "Mac OS X .DS_Store" do
  #     
  #     before(:each) do
  #       @asset = Factory :asset, :file => '.DS_Store'
  #     end
  #     
  #     it_should_behave_like 'invalid files'
  #   end
  # 
  #   describe "Windows Thumbs.db" do
  #     it_should_behave_like 'invalid files'
  #   end
  #   
  #   describe "(.) as a filename" do
  #     it_should_behave_like 'invalid files'
  #   end
  # 
  # 
  #   
  # end
  # 
  # describe "empty files" do
  # 
  #   it "should be empty" do
  #     pending
  #   end
  #   
  #   it "shouldn't be valid" do
  #     pending
  #   end
  #   
  # end
  # 
  #  
  #  
  # # Moving files around
  # describe "moving files" do
  #   
  # 
  #   describe "with valid names" do
  #     
  #     it "shouldn't change it's basename" do
  #       pending
  #     end
  #     
  #     it "shouldn't change it's name" do
  #       pending
  #     end
  #     
  #     it "shouldn't change it's extension" do
  #       pending
  #     end
  #     
  #   end
  #   
  #   describe "with names that were changed from sanitation" do
  #     
  #     it "should change it's basename" do
  #       pending
  #     end
  #     
  #     it "should change it's name" do
  #       pending
  #     end
  #     
  #     it "shouldn't change it's extension" do
  #       pending
  #     end
  # 
  #   end
  #   
  # end
  # 

  
end
