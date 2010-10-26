require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the AssetHelper. For example:
#
# describe AssetHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe AssetHelper do


  describe "asset_image_tag" do
    
    before(:each) do
      @asset = Factory :asset
      @output = helper.asset_image_tag(@asset, :preview)
    end
    
    
    it "should output html for an image" do
      @output.should =~ /<img/
    end
    
    it "should have a src for the image" do
      @output.should =~ /src="/
    end
    
    it "should have a class" do
      @output.should =~ /class="/
    end
    
  end

end
