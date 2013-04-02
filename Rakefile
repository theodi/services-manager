require 'dotenv'
Dotenv.load

require 'resque/tasks'
require 'resque_scheduler/tasks'

task :default => 'resque:setup'

namespace :resque do
  task :setup do
    require 'resque'
    require 'resque_scheduler'
    require 'resque/scheduler'
    require 'open-orgn-services'
    require 'resque/failure/redis'
    require 'resque/failure/airbrake'
    require 'resque/failure/multiple'
    # Set up failure notifications
    if ENV['AIRBRAKE_SERVICES_KEY']
      Resque::Failure::Multiple.classes = [Resque::Failure::Redis, Resque::Failure::Airbrake]
      Resque::Failure.backend = Resque::Failure::Multiple
      Airbrake.configure do |config|
        config.api_key = ENV['AIRBRAKE_SERVICES_KEY']
      end
    else
      Resque::Failure.backend = Resque::Failure::Redis
    end
    # Load schedule
    Resque.schedule = YAML.load_file('config/schedule.yml')
  end
end