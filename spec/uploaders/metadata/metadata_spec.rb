require "spec_helper"

describe "Metadata" do

  shared_examples_for 'indexed assets' do
    
    it "should have some metadata" do
      @metadata.should_not be_empty
    end
    
    it "should should have a content_type tree" do
      @raw[:content_type_tree].should_not be_empty
    end

    it "should have at least three members in the tree" do
      @raw[:content_type_tree].should have_at_least(3).things
    end
    
    it "should have a kind" do
      @raw[:kind].should_not be_empty
    end
    

  end
  


  describe "indexed files" do
    
    before(:each) do
      @metadata = Metadata.create :path => asset_fixtures_path('images/example.jpg')
      @raw = @metadata.raw
    end

    it_should_behave_like 'indexed assets'
    
    
    describe "cleaning up the metadata" do
      
      it "should have a kind of JPEG" do
        @raw[:kind].should == "JPEG image"
      end
      
      it "should have a content_type of 'public.image'" do
        @raw[:content_type].should == 'public.jpeg'
      end
      
      describe "content type tree" do
        
        ['public.jpeg', 'public.image', "public.data", "public.item", "public.content"].each do |t|
        
          it "should include '#{t}'" do
            @raw[:content_type_tree].should include(t)
          end
        end
      end
      
      
      it "should say it has a pixel width" do
        @raw[:pixel_width].should_not be_nil
      end

    end
    
  end
  
  
  describe "non-indexed files" do
    
    before(:each) do
      @metadata = Metadata.create :path => asset_fixtures_path('.hidden/example.pdf')
    end
    
    it "should not have metadata" do
      @metadata.raw.should be_nil
    end
    
    
  end

  
end