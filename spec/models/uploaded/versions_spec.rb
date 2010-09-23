require "spec_helper"

describe "File Versioning" do
  
  
  shared_examples_for 'a file version' do
    
    it "should have a preview" do
      pending
    end
    
    it "should have thumbnails" do
      pending
    end
    
    it "should have a original file" do
      pending
    end
    
    it "should have a md5 of the original file" do
      pending
    end
    
    it "should have a parent asset" do
      pending
    end
    
    it "should have a creation date" do
      pending
    end
    
  end

  
  describe "the parent asset" do
    
    describe "with only one version of the file" do
      
      it_should_behave_like 'a file version'
      
      it "should have only one version" do
        pending
      end
    
      it "shouldn't say it has versions" do
        pending
      end
      
    end
    
    describe "creating versions" do
      
      describe "with a new/different file" do
      
        it_should_behave_like 'a file version'
      
        it "should say that it has a new version" do
          pending
        end
      
        it "should say which attributes have changed" do
          pending
        end
      
        it "should increment the number of verions the asset has" do
          pending
        end
      end
    
      describe "with the same file (shouldn't increment)" do
      
        it_should_behave_like 'a file version'
      
        it "shouldn't say that it has a new version" do
          pending
        end
      
        it "shouldn't increment the number of versions the asset has" do
          pending
        end
      
      end

    end
    
    describe "with multiple versions of the file" do
      
      it "should have more than one version" do
        pending
      end
      
      it "should say it has versions" do
        pending
      end
      
      it "should be able to say which one is the hero" do
        pending
      end
      
      it "should be able to change the hero" do
        pending
      end
      
      it "should be able to remove a specific version of the file" do
        pending
      end
    end
    
  end

  
end
