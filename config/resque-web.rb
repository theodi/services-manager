require 'dotenv'
Dotenv.load

require 'resque'

# Include resque scheduler stuff for web interface
require 'resque_scheduler'
require 'resque_scheduler/server'
require 'resque-history/server'

require 'open-orgn-services'

Resque::Scheduler.dynamic = true


if ENV["SERVICES_MANAGER_USERNAME"] && ENV["SERVICES_MANAGER_PASSWORD"]
  Resque::Server.use(Rack::Auth::Basic) do |user, password|
    user == ENV["SERVICES_MANAGER_USERNAME"] && password == ENV["SERVICES_MANAGER_PASSWORD"]
  end
end