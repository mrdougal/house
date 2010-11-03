require "spec_helper"


describe "Thumbnail dimensions" do
  
  describe "reading previews" do
  
    describe "tall preview" do
    
      before(:each) do

        @asset = Factory.stub :asset
        @file = File.new(File.join(Rails.root, 'spec/fixtures/assets/previews/438x800.png' ))

        @preview = @asset.preview
        @preview.stub(:exists?).and_return true
        @preview.stub(:path).and_return @file.path
      
      end
        
      describe "dimensions" do
      
        it "should be 438 pixels width" do
          @preview.width.should == 438
        end
      
        it "should be 800 pixels height" do
          @preview.height.should == 800
        end
        
        it "should not be horizontal" do
          @preview.should_not be_horizontal
        end
      
        it "should be vertical" do
          @preview.should be_vertical
        end
      
        it "should not be square" do
          @preview.should_not be_square
        end
      
        it "should say that height is larger" do
          @preview.larger.should == 800
        end
      
        it "should say that width is smaller" do
          @preview.smaller.should == 438
        end
      
        it "should say that the aspect ratio is 0.55" do
          @preview.aspect.should be_close(0.55, 0.01)
        end
      
      end
    
    end
  
    describe "wide preview" do
    
      before(:each) do

        @asset = Factory.stub :asset
        @file = File.new(File.join(Rails.root, 'spec/fixtures/assets/previews/800x354.png' ))

        @preview = @asset.preview
        @preview.stub(:exists?).and_return true
        @preview.stub(:path).and_return @file.path
      
      end
        
      describe "dimensions" do
      
        it "should be 800 pixels width" do
          @preview.width.should == 800
        end
      
        it "should be 354 pixels height" do
          @preview.height.should == 354
        end
        
        it "should not be horizontal" do
          @preview.should be_horizontal
        end
      
        it "should not be vertical" do
          @preview.should_not be_vertical
        end
      
        it "should not be square" do
          @preview.should_not be_square
        end
      
        it "should say that height is larger" do
          @preview.larger.should == 800
        end
      
        it "should say that width is smaller" do
          @preview.smaller.should == 354
        end
      
        it "should say that the aspect ratio is 0.55" do
          @preview.aspect.should be_close(2.25, 0.01)
        end
        
      
      end
    
    end
  
    describe "square preview" do
    
      before(:each) do

        @asset = Factory.stub :asset
        @file = File.new(File.join(Rails.root, 'spec/fixtures/assets/previews/700x700.png' ))

        @preview = @asset.preview
        @preview.stub(:exists?).and_return true
        @preview.stub(:path).and_return @file.path
      
      end
        
      describe "dimensions" do
      
        it "should be 700 pixels width" do
          @preview.width.should == 700
        end
      
        it "should be 700 pixels height" do
          @preview.height.should == 700
        end
      
        it "should not be horizontal" do
          @preview.should_not be_horizontal
        end
      
        it "should not be vertical" do
          @preview.should_not be_vertical
        end
      
        it "should be square" do
          @preview.should be_square
        end
      
        it "should say that the larger side is 700" do
          @preview.larger.should == 700
        end
      
        it "should say that the smaller side is 700" do
          @preview.smaller.should == 700
        end
      
        it "should say that the aspect ratio is 1.0" do
          @preview.aspect.should == 1.0
        end
      
      end
    
    end
  
  end
   
   
   
    
end