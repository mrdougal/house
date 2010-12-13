require 'spec_helper'

describe Asset do
  
  describe "download stats" do
    
    before(:each) do
      @asset = Factory :asset
    end
    
    it "should be zero" do
      @asset.download_count.should be_zero
    end
    
    describe "increment the count" do
      
      before(:each) do
        @asset.update_download_stats
      end
      
      it "should increment the count" do
        @asset.download_count.should == 1
      end
    end

  end

end
