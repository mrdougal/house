require 'spec_helper'

describe "Archive Extraction" do
  
  
  shared_examples_for 'common archive behaviour' do
    
    it "should respond to extract" do
      pending
    end

    it "should be an archive" do
      pending
    end
    
  end
  
  describe "detection of archives" do
    
    
    describe "zip archives" do
      
      it_should_behave_like 'common archive behaviour'
    end
    
    describe "tar archives" do
      
      it_should_behave_like 'common archive behaviour'

    end
    
    describe "other random archives" do
      
      it_should_behave_like 'common archive behaviour'
      
    end
    
    
  end
  
  # iWork 08 documents are packages and therefore need to be zipped prior to uploading.
  # Recent versions of Safari will automatically do this.
  # Chrome and Firefox (and most likely IE) will attempt to upload the package
  # 
  # iWork 09 docs are naturally zip archives
  describe "detection of iWork documents" do
    
    shared_examples_for 'iWork doc' do
      
      it "should respond to iWork?" do
        pending
      end
      
    end
    
    describe "iWork O8 docs" do
      
      
      describe "pages" do
        
        it_should_behave_like 'iWork doc'

        it "should have pages in the extension" do
          pending
        end
      end
      
      describe "numbers" do
        
        it_should_behave_like 'iWork doc'
        
        it "should have numbers in the extension" do
          pending
        end
      end
      
      describe "keynote" do
        
        it_should_behave_like 'iWork doc'
        
        it "should have key in the extension" do
          pending
        end
      end
    end
    
    describe "iWork 09 docs" do
      
      describe "pages" do
        
        it_should_behave_like 'iWork doc'
        
        it "should have pages in the extension" do
          pending
        end
      end
      
      describe "numbers" do

        it_should_behave_like 'iWork doc'
        
        it "should have numbers in the extension" do
          pending
        end
      end
      
      describe "keynote" do
        
        it_should_behave_like 'iWork doc'
        
        it "should have key in the extension" do
          pending
        end
      end
    end
  end
  
  
  
end