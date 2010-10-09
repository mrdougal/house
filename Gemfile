source 'http://rubygems.org'

gem 'rails', '3.0.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# We are using MongoDB for our database and MongoID as our ORM
gem "mongoid", "2.0.0.beta.17"
gem "bson_ext", "1.0.4"


# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end


# Rspec needs to be in the development group 
# to expose generators and rake tasks 
# without having to type RAILS_ENV=test.

group :development, :test do
  
  gem "rspec-rails", ">= 2.0.0.rc"

  # # Zen test suite
  # gem "autotest-rails", "4.1.0"
  # gem "autotest-fsevent", "0.1.1"
  # gem "autotest-growl", "0.2.0"
  # 
  # Above gem doesn't work right now, but i've included as *i want it to work*
  
  gem 'factory_girl_rails'
  
  # Required so that Rspec can test views
  # gem 'webrat'
  
end
