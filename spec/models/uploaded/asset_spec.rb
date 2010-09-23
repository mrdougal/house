require "spec_helper"


describe "Asset" do
  
  
  
  shared_examples_for 'all valid files' do
    
    it "should have an extension" do
      pending
    end
    
    it "should have a name" do
      pending
    end
    
    it "should have a basename" do
      pending
    end
    
    it "should have a path" do
      pending
    end
    
    it "should have a url" do
      pending
    end
    
    it "should have a size" do
      pending
    end
    
  end
  
  
  
  describe "filenames" do
    
    describe "from real world file names" do
      it_should_behave_like 'all valid files'
    end
    
    describe "with complicated extensions" do
      it_should_behave_like 'all valid files'
    end
    
  end
  
  describe "santizing names" do
    
    it_should_behave_like 'all valid files'
    
    it "should remove illegal characters" do
      pending
    end
    
    it "should remove the path prefix (as IE does)" do
      pending
    end
    
  end
  
  describe "illegal files" do

    it "should ignore Mac OS X .DS_Store" do
      pending
    end
    
    it "should ignore Windows Thumbs.db" do
      pending
    end
    
    it "shouldn't allow (.) as a filename" do
      pending
    end
    
    it "shouldn't be valid" do
      pending
    end
    
    it "shouldn't have a preview" do
      pending
    end
    
    it "shouldn't have thumbnails" do
      pending
    end
    
  end
  
  describe "empty files" do

    it "should be empty" do
      pending
    end
    
    it "shouldn't be valid" do
      pending
    end
    
  end
  
 
 
  # Moving files around
  describe "moving files" do
    

    describe "with valid names" do
      
      it "shouldn't change it's basename" do
        pending
      end
      
      it "shouldn't change it's name" do
        pending
      end
      
      it "shouldn't change it's extension" do
        pending
      end
      
    end
    
    describe "with names that were changed from sanitation" do
      
      it "should change it's basename" do
        pending
      end
      
      it "should change it's name" do
        pending
      end
      
      it "shouldn't change it's extension" do
        pending
      end

    end
    
  end
  

  # Structure
  describe "structure" do
    

    describe "Parent/Original file" do
      
      it_should_behave_like 'all valid files'
      
      it "should have a preview" do
        pending
      end

      it "should have thumbnails" do
        pending
      end
      
    end
    
    
    describe "Preview" do
      
      it_should_behave_like 'all valid files'
      
      it "should have a parent/original" do
        pending
      end
      
      it "should have thumbnails" do
        pending
      end
      
    end
    
    describe "Thumbnail" do

      it_should_behave_like 'all valid files'
      
      it "should have a parent/original" do
        pending
      end
      
      it "should have a preview" do
        pending
      end
      
    end

  end
  
end