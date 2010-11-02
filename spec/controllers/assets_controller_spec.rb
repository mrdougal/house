require 'spec_helper'

describe AssetsController do

  def mock_asset(stubs={})
    @mock_asset ||= mock_model(Asset, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all assets as @assets" do
      Asset.stub(:all) { [mock_asset] }
      get :index
      assigns(:assets).should eq([mock_asset])
    end
  end

  describe "GET new" do
    it "assigns a new asset as @asset" do
      Asset.stub(:new) { mock_asset }
      get :new
      assigns(:asset).should be(mock_asset)
    end
  end

  describe "GET edit" do
    it "assigns the requested asset as @asset" do
      Asset.stub(:find).with("37") { mock_asset }
      get :edit, :id => "37"
      assigns(:asset).should be(mock_asset)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created asset as @asset" do
        Asset.stub(:new).with({'these' => 'params'}) { mock_asset(:save => true) }
        post :create, :asset => {'these' => 'params'}
        assigns(:asset).should be(mock_asset)
      end

      it "redirects to the created asset" do
        Asset.stub(:new) { mock_asset(:save => true) }
        post :create, :asset => {}
        response.should redirect_to(asset_url(mock_asset))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved asset as @asset" do
        Asset.stub(:new).with({'these' => 'params'}) { mock_asset(:save => false) }
        post :create, :asset => {'these' => 'params'}
        assigns(:asset).should be(mock_asset)
      end

      it "re-renders the 'new' template" do
        Asset.stub(:new) { mock_asset(:save => false) }
        post :create, :asset => {}
        response.should render_template("new")
      end
    end

  end



  describe "asset with no preview" do
    
    before(:each) do
      @asset = Factory :asset
    end
      
    describe "GET show" do
    
      it "assigns the requested asset as @asset" do
        get :show, :id => @asset.id.to_s
        response.should be_success
      end
    end
    
    describe "PUT update" do

      describe "with valid params" do
        it "updates the requested asset" do
          Asset.should_receive(:find).with("37") { mock_asset }
          mock_asset.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "37", :asset => {'these' => 'params'}
        end

        it "assigns the requested asset as @asset" do
          Asset.stub(:find) { mock_asset(:update_attributes => true) }
          put :update, :id => "1"
          assigns(:asset).should be(mock_asset)
        end

        it "redirects to the asset" do
          Asset.stub(:find) { mock_asset(:update_attributes => true) }
          put :update, :id => "1"
          response.should redirect_to(asset_url(mock_asset))
        end
      end

      describe "with invalid params" do
        it "assigns the asset as @asset" do
          Asset.stub(:find) { mock_asset(:update_attributes => false) }
          put :update, :id => "1"
          assigns(:asset).should be(mock_asset)
        end

        it "re-renders the 'edit' template" do
          Asset.stub(:find) { mock_asset(:update_attributes => false) }
          put :update, :id => "1"
          response.should render_template("edit")
        end
      end

    end
    
    describe "preview and thumbnails" do
      
      describe "GET preview" do
        
        it "should have a status of 202 (accepted)" do
          get :preview, :id => @asset.id.to_s
          response.status.should == 202
        end
        
        it "should have a mime type of image/png" do

          get :preview, :id => @asset.id.to_s
          response.content_type.should == 'image/png'
        end
        
      end
      
      describe "small thumbnail" do
        
        it "should have a status of 202 (accepted)" do
          get :small, :id => @asset.id.to_s
          response.status.should == 202 
        end
        
        it "should have a mime type of image/png" do

          get :small, :id => @asset.id.to_s
          response.content_type.should == 'image/png'
        end
        
      end
      
      describe "medium thumbnail" do
        
        it "should have a status of 202 (accepted)" do
          get :medium, :id => @asset.id.to_s
          response.status.should == 202 
        end

        it "should have a mime type of image/png" do

          get :medium, :id => @asset.id.to_s
          response.content_type.should == 'image/png'
        end

      end
      
      describe "large thumbnail" do
        
        it "should have a status of 202 (accepted)" do
          get :large, :id => @asset.id.to_s
          response.status.should == 202 
        end

        it "should have a mime type of image/jpg" do

          get :large, :id => @asset.id.to_s
          response.content_type.should == 'image/jpg'
        end

      end

    end
    
  end
  
  describe "asset with a preview" do
      
    before(:each) do
      @asset = Factory :processed_asset
      @asset.preview.stub(:exists?).and_return true
    end

    it "should have a status of 200" do

      get :preview, :id => @asset.id.to_s
      response.status.should == 200
    end
    
    it "should have a mime type of image/png" do
      
      get :preview, :id => @asset.id.to_s
      response.content_type.should == 'image/png'
    end
    
  end

  


  describe "DELETE destroy" do
    it "destroys the requested asset" do
      Asset.should_receive(:find).with("37") { mock_asset }
      mock_asset.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the assets list" do
      Asset.stub(:find) { mock_asset }
      delete :destroy, :id => "1"
      response.should redirect_to(assets_url)
    end
  end

end
