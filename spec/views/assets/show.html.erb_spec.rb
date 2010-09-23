require 'spec_helper'

describe "assets/show.html.erb" do

  before(:each) do
    @asset = Factory :asset
  end

  it "renders attributes in <p>" do
    render
  end
end
