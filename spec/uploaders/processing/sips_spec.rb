require "spec_helper"


describe "Sips" do
  
  before(:each) do

    @file = File.new(File.join(Rails.root, 'spec/fixtures/assets/previews/438x800.png' ))

    @target = Factory(:thumb_small)
    @target.stub(:path).and_return @file.path

    @sips = Upload::Sips.new :target => @target, :source => @file 
    
  end

  describe "format" do
    
    it "should return a format" do
      @sips.format.should_not be_nil
    end
    
    it "should quote jpeg from jpg" do
      @target.stub(:format).and_return 'jpg'
      @sips.format.should == 'jpeg'
    end
    
    it "should quote jpeg from jpeg" do
      @target.stub(:format).and_return 'jpeg'
      @sips.format.should == 'jpeg'
    end
    
    it "should quote png from png" do
      @target.stub(:format).and_return 'png'
      @sips.format.should == 'png'
    end

  end
  
  describe "dimensions" do
    
    describe "for source" do
      
      it "should return a hash with height as a key" do
        @sips.source_dimensions.should have_key(:height)
      end
    
      it "should return a hash with width as a key" do
        @sips.source_dimensions.should have_key(:width)
      end
    end

    describe "for target" do
      
      it "should return a hash with height as a key" do
        @sips.target_dimensions.should have_key(:height)
      end
    
      it "should return a hash with width as a key" do
        @sips.target_dimensions.should have_key(:width)
      end
      
    end
  end

  describe "cropping" do
    
    it "should say that it needs to be cropped" do
      @target.crop.should be_true
    end
    
  end
end