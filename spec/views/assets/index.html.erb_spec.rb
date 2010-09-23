require 'spec_helper'

describe "assets/index.html.erb" do
    
  before(:each) do
    @assets = [ Factory(:asset), Factory(:asset) ]
  end

  it "renders a list of assets" do
    render
  end
end
