require "spec_helper"


describe "Thumbnail" do
  
  shared_examples_for 'any thumbnail' do
      
    it "should be a jpg or png" do
      pending
    end
    
    it "should have dimension of less than 200x200 pixels" do
      pending
    end
    
    it "should have a path underneath the parent" do
      pending
    end
    
    it "should have a url underneath the parent" do
      pending
    end
  end

  describe "large" do
    
    it_should_behave_like 'any thumbnail'
    
    it "should be at least 100 pixels width" do
      pending
    end
    
    it "should be at least 100 pixels talls" do
      pending
    end
  end
  
  
  describe "small/thumb" do

    it_should_behave_like 'any thumbnail'

    it "should be less than 50 pixel wide" do
      pending
    end
    
    it "should be less than 50 pixels high" do
      pending
    end
  end

  
  
end