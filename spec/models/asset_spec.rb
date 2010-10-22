require 'spec_helper'

describe Asset do


  [images, composite].flatten.each do |val|

    describe "Creation of asset #{val}" do

      before(:each) do
        @asset = Asset.new :file => get_fixture(val)
        @asset.save

        # For reference in the tests, as 'val' includes a pathname
        @f = File.basename(val)
      end

      it "should be valid" do
        @asset.should be_valid
      end

      it "should have a basename of #{@f}" do
        @asset.basename.should == @f
      end

      it "should have a filesize" do
        @asset.original_filesize.should_not be_zero
      end

      it "should respond to name" do
        @asset.should respond_to(:name)
      end

      it "should return '#{@f}' as it's" do
        @asset.name.should == File.basename(val)
      end

      it "should return '#{@f}' from to_s" do
        @asset.to_s.should == @f
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
