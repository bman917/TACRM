# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
TACRM::Application.initialize!

Time::DATE_FORMATS[:time] = "%B %d, %Y %I:%M %p"