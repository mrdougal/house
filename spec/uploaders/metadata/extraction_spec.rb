# encoding: UTF-8

require "spec_helper"

describe "Metadata Extraction" do

  shared_examples_for 'indexed assets' do
    
    
    describe "content type tree" do
      
      [ "public.data", "public.item"].each do |t|
      
        it "should include '#{t}'" do
          @metadata.content_type_tree.should include(t)
        end
      end
    end
    
    
    it "should have some metadata" do
      @asset.metadata.should_not be_empty
    end
    
    it "should should have a content_type tree" do
      @metadata.content_type_tree.should_not be_empty
    end

    it "should have at least three members in the tree" do
      @metadata.content_type_tree.should have_at_least(3).things
    end
    
    it "should have a kind" do
      @metadata.kind.should_not be_empty
    end
    
    it "should not have path" do
      @metadata.should_not respond_to(:path)
    end
    

  end
  
  shared_examples_for 'bitmap images' do
    
    
    describe "content type tree" do
      
      ['public.image'].each do |t|
      
        it "should include '#{t}'" do
          @metadata.content_type_tree.should include(t)
        end
      end
    end
    
    it "should say it has a pixel width" do
      @metadata.pixel_width.should_not be_nil
    end

    it "should say it has a pixel height" do
      @metadata.pixel_height.should_not be_nil
    end
    
  end

  shared_examples_for 'composite assets' do
    
    it "should include 'public.composite-content'" do
      @metadata.content_type_tree.should include("public.composite-content")
    end
    
    it "should have page height" do
      @metadata.page_height.should_not be_nil
    end

    it "should have page width" do
      @metadata.page_width.should_not be_nil
    end

  end






  describe "indexed files" do
    
    describe "bitmaps" do
    
      describe "example.jpg" do
      
        before(:each) do
          @asset = Factory :asset, :file => get_fixture('images/example.jpg')
          @metadata = @asset.metadata
        end

        it_should_behave_like 'indexed assets'
        it_should_behave_like 'bitmap images'
  
        it "should have a kind of JPEG" do
          @metadata.kind.should == "JPEG image"
        end
    
        it "should have a content_type of 'public.image'" do
          @metadata.content_type.should == 'public.jpeg'
        end
      end
    
      describe "example.png" do
      
        before(:each) do
          @asset = Factory :asset, :file => get_fixture('images/example.png')
          @metadata = @asset.metadata
          
        end

        it_should_behave_like 'indexed assets'
        it_should_behave_like 'bitmap images'
  
        it "should have a kind of PNG" do
          @metadata.kind.should == "Portable Network Graphics image"
        end
    
        it "should have a content_type of 'public.png'" do
          @metadata.content_type.should == 'public.png'
        end
        
        
        it "should say it has a pixel width" do
          @metadata.pixel_width.should == 1200
        end

        it "should say it has a pixel height" do
          @metadata.pixel_height.should == 800
        end
        
        
        
      
      end
      
    end
    
    describe "composites" do
      
      describe "example.pdf" do

        before(:each) do
          
          @asset = Factory :asset, :file => get_fixture('composite/example.pdf')
          @metadata = @asset.metadata
        end

        it_should_behave_like 'indexed assets'

        it "should have a kind of PDF" do
          @metadata.kind.should == "Portable Document Format (PDF)"
        end

        it "should have a content_type of 'com.adobe.pdf'" do
          @metadata.content_type.should == 'com.adobe.pdf'
        end
        
        it "should have a creator" do
          @metadata.creator.should_not be_nil
        end
        
        it "should have 2 pages" do
          @metadata.number_of_pages.should == 2
        end
        
        it "should have a security method" do
          @metadata.security_method.should == "None"
        end
        
      end
      
      describe "example.eps" do
        
        before(:each) do
          @asset = Factory :asset, :file => get_fixture('composite/example.eps')
          @metadata = @asset.metadata
        end

        it_should_behave_like 'indexed assets'

        it "should have a kind of EPS" do
          @metadata.kind.should == "Encapsulated PostScript"
        end

        it "should have a content_type of 'com.adobe.encapsulated-postscript'" do
          @metadata.content_type.should == 'com.adobe.encapsulated-postscript'
        end

        it "should have a creator" do
          @metadata.creator.should_not be_nil
        end

        it "should have 1 page" do
          @metadata.number_of_pages.should == 1
        end

      end
      
    end
    
    describe "fonts" do
      
      describe "type type font" do

        before(:each) do
          @asset = Factory :asset, :file => get_fixture('fonts/windows true type.ttf')
          @metadata = @asset.metadata
        end

        it_should_behave_like 'indexed assets'
        
        it "should have a kind of Windows TrueType font" do
          @metadata.kind.should == "Windows TrueType font"
        end
        
        it "should have a content_type of 'public.truetype-ttf-font'" do
          @metadata.content_type.should == 'public.truetype-ttf-font'
        end
        
        it "should have public.font in the content type tree" do
          @metadata.content_type_tree.should include('public.font')
        end
        
        it "should have a copyright notice" do
          @metadata.copyright.should =~ /©/
        end
        
        it "should have a publishers" do
          @metadata.publishers.should include("Microsoft Typography")
        end
        
        it "should have a postscript name" do
          @metadata.com_apple_ats_name_fond.should include("Wingdings-Regular")
        end
        
        it "should have a font family name" do
          @metadata.com_apple_ats_name_family.should include("Wingdings")
        end
        
      end
    end
    
  end
  
  
  describe "non-indexed files" do
    
    before(:each) do
      @asset = Factory :asset, :file => get_fixture('.hidden/example')
    end
    
    it "should say metadata is empty" do
      @asset.metadata.should be_empty
    end
    
    it "should say it doesn't have metadata" do
      @asset.should_not be_metadata
    end

    it "metadata shoud respond to extract (even if empty)" do
      @asset.metadata.should respond_to(:extract)
    end
    
  end

  
end