# Load the rails application
require File.expand_path('../application', __FILE__)

# The location of the asset uploads. Note it differs for test
House::Application.configure do

  config.upload_base_path = File.expand_path("#{Rails.root}/../site.uploads")

end

# Initialize the rails application
House::Application.initialize!
