require "spec_helper"


describe "Sips" do
  
  before(:each) do
    @target = Factory(:thumb)
    @sips = Upload::Sips.new :target => @target
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
  
  
  it "should know the dimensions of a file" do
    pending
  end

  describe "arguments for cropping" do
    pending
  end
  
end