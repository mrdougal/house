require "spec_helper"

describe AssetsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/assets" }.should route_to(:controller => "assets", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/assets/new" }.should route_to(:controller => "assets", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/assets/1" }.should route_to(:controller => "assets", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/assets/1/edit" }.should route_to(:controller => "assets", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/assets" }.should route_to(:controller => "assets", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/assets/1" }.should route_to(:controller => "assets", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/assets/1" }.should route_to(:controller => "assets", :action => "destroy", :id => "1")
    end

  end
end
