source 'https://rubygems.org'

#ruby=ruby-1.9.3
#ruby-gemset=services-manager

gem 'dotenv'

# These should be grabbed from git, not rubygems, as we have our own fixes
gem 'capsulecrm', github: 'xmacinka/capsulecrm'
gem 'google_drive', github: 'theodi/google-drive-ruby', branch: 'support-ranges'
gem 'eventbrite-client', github: 'theodi/eventbrite-client.rb', branch: 'update-dependencies'

# Include ALL THE CODE
gem 'open-orgn-services', :git =>  'https://github.com/theodi/open-orgn-services.git'

# Queue runner code
gem 'rufus-scheduler', '< 3.0.0'
gem 'resque-scheduler', :require => 'resque_scheduler'
gem 'resque-history'
gem 'thin'
gem 'foreman', '< 0.65'

gem 'airbrake'
gem 'fog'
