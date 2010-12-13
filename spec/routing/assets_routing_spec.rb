require "spec_helper"

describe AssetsController do
  describe "routing" do

    describe "standard crud" do
      
      it "recognises and generates #index" do
        { :get => "/assets" }.should route_to(:controller => "assets", :action => "index")
      end

      it "recognises and generates #new" do
        { :get => "/assets/new" }.should route_to(:controller => "assets", :action => "new")
      end

      it "recognises and generates #show" do
        { :get => "/assets/1" }.should route_to(:controller => "assets", :action => "show", :id => "1")
      end

      it "recognises and generates #edit" do
        { :get => "/assets/1/edit" }.should route_to(:controller => "assets", :action => "edit", :id => "1")
      end

      it "recognises and generates #create" do
        { :post => "/assets" }.should route_to(:controller => "assets", :action => "create")
      end

      it "recognises and generates #update" do
        { :put => "/assets/1" }.should route_to(:controller => "assets", 
                                                :action => "update", 
                                                :id => "1")
      end

      it "recognises and generates #destroy" do
        { :delete => "/assets/1" }.should route_to( :controller => "assets", 
                                                    :action => "destroy", 
                                                    :id => "1")
      end
    end
    
    describe "preview" do

      it "recognises and generates #preview (with png as the default format)" do
        { :get => "/assets/1/preview" }.should route_to( :controller => "assets", 
                                                         :action => "preview", 
                                                         :id => "1",
                                                         :format => "png" )
      end
      
      it "recognises and generates #preview as a png" do
        { :get => "/assets/1/preview.png" }.should route_to( :controller => "assets", 
                                                             :action => "preview", 
                                                             :id => "1",
                                                             :format => 'png'  )
      end

      it "recognises and generates #preview as a jpg" do
        { :get => "/assets/1/preview.jpg" }.should route_to( :controller => "assets", 
                                                             :action => "preview", 
                                                             :id => "1",
                                                             :format => 'jpg'  )
      end
      
    end
    
    
    describe "thumbnails" do
      
      it "recognises and generates #small (with a format of png)" do
        { :get => "/assets/1/small" }.should route_to(  :controller => "assets",
                                                        :action => "small",
                                                        :id => "1",
                                                        :format => "png"    )
      end

      it "recognises and generates #medium (with a format of png)" do
        { :get => "/assets/1/medium" }.should route_to( :controller => "assets",
                                                        :action => "medium",
                                                        :id => "1",
                                                        :format => "png"    )
      end
      
      it "recognises and generates #large (with a format of jpg)" do
        { :get => "/assets/1/large" }.should route_to(  :controller => "assets",
                                                        :action => "large",
                                                        :id => "1",
                                                        :format => "jpg"    )
      end
      

    end
    
    
    describe "download" do

      it "recognises and generates #download" do
        { :get => "/assets/1/download" }.should route_to( :controller => "assets",
                                                          :action => "download",
                                                          :id => "1")
      end


      it "recognises and generates #download pdf" do
        { :get => "/assets/1/download.pdf" }.should route_to( :controller => "assets",
                                                          :action => "download",
                                                          :id => "1", 
                                                          :format => "pdf" )
      end
      
    end


  end
end
