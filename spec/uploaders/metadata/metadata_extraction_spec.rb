require 'spec_helper'

describe "metadata extraction" do
  
  
  shared_examples_for "all files" do
    
    it "should have a name" do
      pending
    end
    
    it "should have a size" do
      pending
    end
  end
  
  shared_examples_for "asset dimensions" do
    
    it "should have a width" do
      pending
    end
    
    it "should have a height" do
      pending
    end
    
  end
  
  describe "videos" do
    
    
    shared_examples_for "common video properties" do
      
      it_should_behave_like 'all files'
      it_should_behave_like 'asset dimensions'
      
      it "should have movie in the content type tree" do
        pending
      end
      
      it "should have a duration" do
        pending
      end
      
    end
    
    
  end
  
  describe "images" do
    
    shared_examples_for "image properties" do
      
      it_should_behave_like 'all files'
      it_should_behave_like 'asset dimensions'

      it "should have a resolution" do
        pending
      end
      
      it "should have a colour space" do
        pending
      end
      
    end
    
    describe "jpeg" do
      it_should_behave_like "image properties"
    end
    
    describe "png" do
      it_should_behave_like 'image properties'
    end
    
    describe "photoshop" do
      it_should_behave_like 'image properties'
      
      it "should have a content creator" do
        pending
      end
    end
  end
  
  describe "composite files" do
    
    it_should_behave_like 'asset dimensions'

    shared_examples_for 'composite properties' do
      
      it "should have a content creator" do
        pending
      end
    
      it "should have a page count" do
        pending
      end
    
      it "should have a resolution" do
        pending
      end
    end

    describe "pdf" do

      it_should_behave_like 'composite properties'
    end

    describe "illustrator (pdf)" do
      
      it_should_behave_like 'composite properties'
    end
    
    describe "postscript" do
      
      it_should_behave_like 'composite properties'
    end

  end
  
  describe "fonts" do
    
    shared_examples_for 'font properties' do
      
      it_should_behave_like 'all files'
      
      it "should have weigths" do
        pending
      end
      
      it "should have a style name" do
        pending
      end
      
      it "should have a copyright notice" do
        pending
      end
      
    end
    
  end
  
  describe "office" do
    
    
    describe "iWork" do
      
      shared_examples_for 'iWork properties' do
        
        it "should list fonts used in the doc" do
          pending
        end
        
        it "should list keywords" do
          pending
        end
      end
      
      describe "pages" do
        it_should_behave_like 'iWork properties'
      end
      
      describe "numbers" do
        it_should_behave_like 'iWork properties'
      end

      describe "keynot" do
        it_should_behave_like 'iWork properties'
      end
    end
    
    describe "Microsoft Office" do
      
      shared_examples_for 'office properties' do
        it "should have a title" do
          pending
        end
        
        it "should have an author" do
          pending
        end
      end
      
      describe "word" do
        it_should_behave_like 'office properties'
      end

      describe "excel" do
        it_should_behave_like 'office properties'
      end
      
      describe "power point" do
        it_should_behave_like 'office properties'
      end
    end
    
    describe "Open office" do
      pending "Not sure if will have support for Open Office"
    end
    
  end
  
  
  
end