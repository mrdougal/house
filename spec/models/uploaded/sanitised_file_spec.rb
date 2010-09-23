
require 'spec_helper'


describe Uploaded::SanitisedFile do
  
  
  describe "example.jpg" do
    
    before(:each) do
      
      # f = mock(open_file('example.jpg'), :original_filename => 'example.jpg')
      
      @file = Uploaded::SanitisedFile.new(open_file('example.jpg'))
    end
    
    it "should have a filename" do
      @file.name.should == 'example.jpg'
    end
    
    it "should have a basename of example" do
      @file.basename.should == 'example'
    end
    
    it "should not be empty" do
      @file.should_not be_empty
    end
    
    it "should have a size" do
      @file.size.should_not be_zero
    end
    
    it "should be something" do
      @file.file.should == ''
    end
    
  end
  
  
  
  
  describe "original filename" do
    
    
    it "should default to the original filename" do
      
      f = mock('file', :original_filename => "example.psd" )
      @file = Uploaded::SanitisedFile.new(f)
      @file.original_filename.should == 'example.psd'
    end
    
    it "should revert to the basename if original_filename is not available" do

      f = mock('file', :path => "/path/to/a.file" )
      
      @file = Uploaded::SanitisedFile.new(f)
      @file.original_filename.should == 'a.file'
    end
    
    it "should be nil othewise" do

      @file = Uploaded::SanitisedFile.new(nil)
      @file.original_filename.should be_nil
    end
    
  end
  
  describe "basename" do
    
    it "should return the basename for complicated extensions" do
      @file = Uploaded::SanitisedFile.new(open_file('example.pdf.gz'))
      @file.basename.should == 'archived.file'
    end
  end

  
  describe "empty?" do
    
    it "should be empty for nil" do
      @file = Uploaded::SanitisedFile.new(nil)
      @file.should be_empty
    end
    
    it "should be empty for an empty string" do
      @file = Uploaded::SanitisedFile.new('')
      @file.should be_empty
    end
    
    it "should be empty for an empty StringIO" do
      @file = Uploaded::SanitisedFile.new(StringIO.new(""))
      @file.should be_empty
    end
    
    it "should be empty for a file with zero bytes" do
      @file = Uploaded::SanitisedFile.new(open_file('zero-bytes.txt'))
      @file.should be_empty
    end
    
  end
  
end


