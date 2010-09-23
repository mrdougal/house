require 'spec_helper'

describe "assets/edit.html.erb" do
    
  before(:each) do
    @asset = Factory :asset
  end

  it "renders the edit asset form" do
    render

    # rendered.should have_selector("form", :action => asset_path(@asset), :method => "post") do |form|
    # end
    
    
  end
end
