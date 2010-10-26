require "spec_helper"


describe "Processed Asset" do
  
  
  shared_examples_for 'an original asset' do
    
    # Names

    it "should have a name" do
      @asset.name.should_not be_blank
    end
    
    it "should have the same name as basename" do
      @asset.name.should == @basename
    end
    
    it "should have a path" do
      @asset.path.should_not be_blank
    end

    it "should contain the basename in the path" do
      @asset.path.should =~ /#{@asset.basename}/
    end
    
    it "should have a size" do
      @asset.size.should_not be_blank
    end
    
    it "should be an original" do
      @asset.should be_original
    end
    
  end
  

  
  
  [images, composite].flatten.each do |val|
    
    describe "asset '#{val}'" do
    
      describe "processed" do

        before(:each) do
          @asset = Factory :processed_asset, :file => get_fixture(val)
          @basename = File.basename(val)
        end      

        it_should_behave_like 'an original asset'
    
        it "should have a preview" do
          @asset.preview.should_not be_nil
        end

        it "should have thumbnails" do
          @asset.thumbnails.should_not be_empty
        end
  
      end
  
      describe "new" do
    
        before(:each) do
          @asset = Factory :asset, :file => get_fixture(val)
          @asset.stub(:new_record?).and_return true
        end
          
        it "should have a preview" do
          @asset.preview.should be_instance_of(Preview)
        end
        
        it "should not have any thumbnails" do
          @asset.thumbnails.should be_nil
        end
    
        it "should be ok to process" do
          @asset.should be_ok_to_process
        end
    
      end  

    end
    
  end

  

  
  
end