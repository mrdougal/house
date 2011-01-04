class ApplicationController < ActionController::Base


  protect_from_forgery
  
  
  rescue_from Mongoid::Errors::DocumentNotFound, :with => :not_found
  
  
  # Application wide 404 page
  def not_found
    render :template => "shared/rescues/not_found", :status => 404  
  end 
  
end
