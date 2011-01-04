# encoding: UTF-8

require "spec_helper"

describe "Metadata Display" do
  
  
  describe "audio" do
    
    before(:each) do
      
      @asset = Factory :asset, :metadata => Factory.attributes_for(:audio)
      @asset.save

      @metadata = @asset.metadata
      
    end
      
      
    describe "display of time" do


      it "should convert 0.0001 seconds to 1/10,000 secound" do
        @metadata.duration_seconds = 0.0001
        @metadata.humanized_attributes['Duration seconds'].should == '1/10,000 second'
      end


      it "should convert 0.5 seconds to 0.5 secounds" do
        @metadata.duration_seconds = 0.5
        @metadata.humanized_attributes['Duration seconds'].should == '1/2 second'
      end

      it "should convert 10.5 seconds to 10.5 secounds" do
        @metadata.duration_seconds = 10.5
        @metadata.humanized_attributes['Duration seconds'].should == '10.5 seconds'
      end
      
      it "should convert 45 seconds to 45 secounds" do
        @metadata.duration_seconds = 45
        @metadata.humanized_attributes['Duration seconds'].should == '45 seconds'
      end

      it "should convert 120 seconds to 2 minutes" do
        @metadata.duration_seconds = 120
        @metadata.humanized_attributes['Duration seconds'].should == '2 minutes'
      end

      it "should convert 121 seconds to 2 minutes" do
        @metadata.duration_seconds = 121
        @metadata.humanized_attributes['Duration seconds'].should == '2.02 minutes'
      end

      it "should convert 150 seconds to 2.5 minutes" do
        @metadata.duration_seconds = 150.0
        @metadata.humanized_attributes['Duration seconds'].should == '2.5 minutes'
      end

      it "should convert 165 seconds to 2.75 minutes" do
        @metadata.duration_seconds = 165
        @metadata.humanized_attributes['Duration seconds'].should == '2.75 minutes'
      end
      
      it "should convert 23456 seconds to 6.5 hours" do
        @metadata.duration_seconds = 23456
        @metadata.humanized_attributes['Duration seconds'].should == '6.52 hours'
      end
      

    end

    
  end



end