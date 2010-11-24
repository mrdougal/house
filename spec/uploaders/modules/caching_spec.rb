require 'spec_helper'

describe "Caching on Assets, Preview and Thumbnails" do
  
  
  describe "Asset" do
    

    describe "cache key" do

      before(:each) do
        @asset = Factory :asset
      end

      it "should not be nil" do
        @asset.cache_key.should_not be_nil
      end

      describe "changing the key" do

        it "should change the cache_key when the filename change" do

          expect { @asset.original_filename = 'different-file.doc' }.to change { @asset.cache_key }
        end

        it "should change the cache_key when the file size change" do

          # We'll bump the size up a few clicks
          expect { @asset.original_filesize += 100 }.to change { @asset.cache_key }
        end


      end

      describe "changing attributes that doesn't effect the cache key" do
        
        it "shouldn't change the cache_key if we change the name" do
          expect { @asset.name = 'Bacon' }.to_not change { @asset.cache_key }
        end
        
      end

    end
  end
  
end