require "spec_helper"


describe "Creating and Updating Asset" do
  
  
  odd_filenames.flatten.each do |val|

    describe "Creation of asset with #{val}" do

      before(:each) do
        @asset = Asset.new :file => get_fixture(val)
        @asset.save 
      end

      it "should be valid" do
        @asset.should be_valid
      end
      
      describe "filesize" do
        
        it "should not be zero" do
          @asset.original_filesize.should_not be_zero
        end
      
        it "should be same as the fixture" do
        
          f = asset_fixtures_path(val)
          @asset.original_filesize.should == File.size(f)
        end
      end
      

      describe "name" do
        
        it "should have a basename of #{File.basename(val)}" do
          @asset.basename.should == File.basename(val)
        end
      
        it "should have an 'original filename of #{File.basename(val)}" do
          @asset.original_filename.should == File.basename(val)        
        end

        it "should respond to name" do
          @asset.should respond_to(:name)
        end

        it "should return '#{File.basename(val)}' as it's basename" do
          @asset.basename.should == File.basename(val)
        end

        it "should return '#{File.basename(val)}' from to_s" do
          @asset.to_s.should == File.basename(val)
        end
        
      end

      describe "adding in name" do
        before(:each) do
          @asset.name = 'Cheese'
        end

        it "should have 'Cheese' as it's name" do
          @asset.name.should == 'Cheese'
        end

        it "should return Cheese from to_s" do
          @asset.to_s.should == 'Cheese'
        end
      end

    end

  end






  
end
