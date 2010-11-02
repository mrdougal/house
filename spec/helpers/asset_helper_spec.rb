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
    end
    
    
    shared_examples_for 'common html output' do
      
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
    
    describe "preview" do

      before(:each) do
        @output = helper.asset_image_tag(@asset, :preview)
      end
      
      it_should_behave_like 'common html output'
      
    end
    
    
    describe "thumbnails" do

      describe "small" do

        before(:each) do
          @output = helper.asset_image_tag(@asset, :small)
        end

        it_should_behave_like 'common html output'
        
        it "should have small in the src" do
          @output.should =~ /small/
        end
        
      end
  
      describe "medium" do

        before(:each) do
          @output = helper.asset_image_tag(@asset, :medium)
        end

        it_should_behave_like 'common html output'
        
        it "should have medium in the src" do
          @output.should =~ /medium/
        end
        
      end

      describe "large" do

        before(:each) do
          @output = helper.asset_image_tag(@asset, :large)
        end

        it_should_behave_like 'common html output'
        
        it "should have large in the src" do
          @output.should =~ /large/
        end
        
        
      end
  
  
  
    end
  end

end
