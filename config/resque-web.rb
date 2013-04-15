require 'dotenv'
Dotenv.load

require 'resque'

# Include resque scheduler stuff for web interface
require 'resque_scheduler'
require 'resque_scheduler/server'

require 'open-orgn-services'

Resque::Scheduler.dynamic = true