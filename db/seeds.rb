# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).


  # Factory girl and asset helpers
  require File.expand_path "#{Rails.root}/spec/factory_helper"
  require File.expand_path "#{Rails.root}/spec/factory_assets_helper"



  # Clear out the db and start again
  puts "Removing assets"
  Asset.destroy_all


  puts "Creating Assets"
  all_files.each do |a|
    
    begin
      
      puts "creating #{a}"
      Factory :asset, :file => get_fixture(a)
    rescue Exception => e
      
      # As not all of the assets will exist
      puts "#{a} doesn't exist in the fixtures dir"
      next
    end
  end