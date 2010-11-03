require "spec_helper"

describe "Asset Preview" do
  
     
     
  shared_examples_for "preview properties" do

    it "should be a png file" do
      @preview.format.should == :png
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
  
  shared_examples_for "preview relationships" do

    it "should have a parent" do
      @preview.parent.should == @asset
    end

    it "should have thumbnails as the parents thumbnails" do
      @preview.thumbnails.should == @asset.thumbnails
    end
  end
     

  [images].flatten.each do |val|

    describe "processed assets" do
      
      before(:each) do
        @asset = Factory :asset, :file => get_fixture(val) 

        # Process the asset
        @asset.process!
        @preview = @asset.preview
        
      end 

      # it_should_behave_like 'preview properties'
      # it_should_behave_like 'preview relationships'
      
      it "should have a path" do
        @preview.path.should_not be_blank
      end
      
      it "should have a preview_created_at time" do
        @asset.preview_created_at.should_not be_nil
      end
      
      describe "dimensions" do
        
        it "should not be nil" do
          @preview.dimensions.should_not be_nil
        end
        
        it "should have a width" do
          @preview.dimensions[:width].should_not be_nil
        end

        it "should have a height" do
          @preview.dimensions[:height].should_not be_nil
        end
      end

    end
    
    describe "unprocessed assets" do
      
      before(:each) do
        @asset = Factory :asset, :file => get_fixture(val) 
        @preview = @asset.preview
      end 
      
      it_should_behave_like 'preview properties'
      it_should_behave_like 'preview relationships'
      
      describe "path" do
        
        it "should not be blank" do
          @preview.path.should_not be_blank
        end
        
        it "should return a path containing 'no_preview.png'" do
          @preview.missing_path.should =~ /no_preview.png/
        end
        
      end
      
      it "should not have a preview_created_at time" do
        @asset.preview_created_at.should be_nil
      end
      
      
    end

    

  end
  

end