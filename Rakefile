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
    require 'odi-metrics-tasks'

    raise "Redis configuration not set" unless ENV['RESQUE_REDIS_HOST'] && ENV['RESQUE_REDIS_PORT']
    Resque.redis = Redis.new(
      :host => ENV['RESQUE_REDIS_HOST'],
      :port => ENV['RESQUE_REDIS_PORT'],
      :password => (ENV['RESQUE_REDIS_PASSWORD'].nil? || ENV['RESQUE_REDIS_PASSWORD']=='' ? nil : ENV['RESQUE_REDIS_PASSWORD'])
    )

    # Enable job history for some classes
    require 'resque-history'
    [
        CapsuleSyncMonitor,
        SendDirectoryEntryToCapsule,
        PartnerEnquiryProcessor,
        SaveMembershipDetailsToCapsule,
        SaveMembershipIdInCapsule,
        SendSignupToCapsule,
        SyncCapsuleData,
        EventMonitor,
        AttendeeMonitor,
        SignupProcessor,
        Invoicer
    ].each do |klazz|
      klazz.class_eval do
        extend Resque::Plugins::History
      end
    end

    # Set up failure notifications
    require 'resque/failure/redis'
    require 'resque/failure/airbrake'
    require 'resque/failure/multiple'
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
    Resque::Scheduler.dynamic = true
    Resque.schedule = YAML.load_file('config/schedule.yml')
  end
end
