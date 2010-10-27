require "spec_helper"


describe "Command Line Module" do
  
  include Upload::CommandLine
  
  describe "escaping filenames" do
    
    
    it "should escape spaces" do
      escape_path('cheese and ham').should == "cheese\\ and\\ ham"
    end
    
    it "should escape single quotes" do
      escape_path("'cheese'").should == "\\'cheese\\'"
    end
    
    it "should escape backslashes" do
      escape_path('cheese\ham').should == "cheese\\\\ham"
    end
    
    it "should escape double quotes" do
      escape_path('bacon"').should == 'bacon\"'
    end
    
    it "should escape spaces and single quotes" do
      escape_path("it's built now what.txt").should == "it\\'s\\ built\\ now\\ what.txt"
    end
        
  end
  
end