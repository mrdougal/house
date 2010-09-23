require 'spec_helper'

describe "assets/new.html.erb" do

  before(:each) do
    
    @asset = Factory :asset
    @asset.stub(:new_record?).and_return(true)
    
    assign(:asset, @asset)
  end

  it "renders new asset form" do
    render

    rendered.should have_selector("form", :action => assets_path, :method => "post") do |form|
    end
  end
  
end
