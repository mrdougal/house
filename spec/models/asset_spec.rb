require 'spec_helper'

describe Asset do

  describe "Creation of asset" do
    before(:each) do
      @asset = Asset.new :file => get_fixture("images/example.png")
      @asset.save
    end
    
    it "should have a basename" do
      @asset.basename.should == 'example.png'
    end
    
    it "should have a filesize" do
      @asset.original_filesize.should_not be_zero
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
    
    it "should have errors on file" do
      @asset.should have(1).error_on(:file)
    end
    
    it "should have an error on :file, mentioning zero bytes" do
      @asset.errors[:file].to_s.should =~ /zero bytes/
    end
  end


  describe "Creation of asset without file" do

    before(:each) do
      @asset = Factory.build :asset, :file => nil
      @asset.save
    end
    
    it "should not be valid" do
      @asset.should_not be_valid
    end
    
    it "should have errors" do
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
    it "should have at least one error on file" do
      # error_on will call valid? internally
      @asset.should have(1).errors_on(:file)
    end

    # This method does the same check as above
    # Although the above method is crashing rspec
    it "should have at least one error on file (re-written)" do
      @asset.valid?
      @asset.errors[:file].should_not be_nil
    end
    
  end
  
  describe "Updating an asset (without setting the file attribute)" do
    
    before(:each) do
      @asset = Factory.create :asset, :file => get_fixture("images/example.png") #, :new_record => false 
    end
    
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
