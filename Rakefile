require 'dotenv'
Dotenv.load

require 'resque/tasks'
require 'resque_scheduler/tasks'

namespace :resque do
  task :setup do
    require 'resque'
    require 'resque_scheduler'
    require 'resque/scheduler'
    require 'open-orgn-services'
    require 'resque/failure/redis'
    Resque::Failure.backend = Resque::Failure::Redis
    # Load schedule
    Resque.schedule = YAML.load_file('config/schedule.yml')
  end
end