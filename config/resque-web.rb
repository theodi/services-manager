require 'dotenv'
Dotenv.load

require 'resque'

# Include resque scheduler stuff for web interface
require 'resque_scheduler'
require 'resque_scheduler/server'
require 'resque-history/server'

require 'open-orgn-services'
require 'odi-metrics-tasks'

raise "Redis configuration not set" unless ENV['RESQUE_REDIS_HOST'] && ENV['RESQUE_REDIS_PORT']

Resque.redis = Redis.new(
  :host => ENV['RESQUE_REDIS_HOST'],
  :port => ENV['RESQUE_REDIS_PORT'],
  :password => (ENV['RESQUE_REDIS_PASSWORD'].nil? || ENV['RESQUE_REDIS_PASSWORD']=='' ? nil : ENV['RESQUE_REDIS_PASSWORD'])
)

Resque::Scheduler.dynamic = true


if ENV["SERVICES_MANAGER_USERNAME"] && ENV["SERVICES_MANAGER_PASSWORD"]
  Resque::Server.use(Rack::Auth::Basic) do |user, password|
    user == ENV["SERVICES_MANAGER_USERNAME"] && password == ENV["SERVICES_MANAGER_PASSWORD"]
  end
end
