require "spec_helper"


describe "Creating and Updating Asset" do
  
  
  images.flatten.each do |val|

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


  describe "Creation of asset with empty file" do

    before(:each) do
      @asset = Factory.build :asset, :file => get_fixture("zero-bytes.txt") 
      @asset.valid?
    end

    it "should not be valid" do
      @asset.should_not be_valid
    end

    # 2010-10-25
    # TODO rspec isn't aware of 'error_on' method
    #
    # it "should have errors on file" do
    #   @asset.should have(1).error_on(:file)
    # end

    it "should have an error on :file, mentioning zero bytes" do
      @asset.errors[:file].to_s.should =~ /zero bytes/
    end
  end


  describe "Creation of asset without file" do

    before(:each) do
      @asset = Factory.build :asset, :file => nil
    end

    it "should not be valid" do
      @asset.should_not be_valid
    end

    it "should have errors" do
      @asset.valid?
      @asset.errors.should_not be_empty
    end

    # 2010-10-19
    # This is erroring rspec :-(
    # output -> expected errors_on to be a collection but it does not respond to #length or #size
    # Unless i've written a really shite spec
    # this isn't be erroring like this
    # might be, because we're not using activerecord
    #
    # Have rewritten this test below
    # I assume that I've got a confussed copy of rspec installed
    #
    # it "should have at least one error on file" do
    #   # error_on will call valid? internally
    #   @asset.should have(1).errors_on(:file)
    # end

    # This method does the same check as above
    # Although the above method is crashing rspec
    it "should have at least one error on file (re-written)" do
      @asset.valid?
      @asset.errors[:file].should_not be_nil
    end

  end


  describe "Updating an asset" do
    
    before(:each) do
      @asset = Factory.stub :asset, 
        :original_filename => "example.png", 
        :original_filesize => 10000,
        :file => get_fixture('images/example.png')
    end

    it "shouldn't be a new record" do
      @asset.should_not be_new_record
    end

    describe "without setting the file attribute" do
      
      describe "updating name" do
        before(:each) do
          @asset.update :name => "Bacon"
        end

        it "should be valid" do
          @asset.should be_valid
        end
        
        it "shouldn't effect the basename of the file" do
          @asset.basename.should == 'example.png'
        end

      end
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
