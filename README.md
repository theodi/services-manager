# Services Manager

[![Build Status](http://jenkins.theodi.org/job/services-manager-master/badge/icon)](http://jenkins.theodi.org/job/services-manager-master/)
[![Dependency Status](https://gemnasium.com/theodi/services-manager.png)](https://gemnasium.com/theodi/services-manager)
[![Code Climate](https://codeclimate.com/github/theodi/services-manager.png)](https://codeclimate.com/github/theodi/services-manager)

This repository a runner for the code in [open-orgn-services](https://github.com/theodi/open-orgn-services)

Setup
-----

Configuration is loaded from environment variables. Copy env.example to .env 
and enter the appropriate details.

This app uses [resque](https://github.com/defunkt/resque) for async job queueing. 
You'll need to install redis, run it, and then run a worker to process jobs. On OSX:

    brew install redis
    redis-server &
    bundle
    VVERBOSE=1 QUEUE=* rake resque:work

Regular jobs are handled by the resque scheduler, which you can run like so:

    QUEUE=* rake resque:scheduler

To get a web interface on your resque workers:

    resque-web config/resque-web.rb

Foreman
-------

[Foreman](http://ddollar.github.com/foreman/) uses the [Procfile](https://github.com/theodi/open-orgn-services/blob/feature-53-infrastructure/Procfile) to launch our Resque services. So we can do like:

    $ foreman start
    14:50:10 worker.1    | started with pid 6122
    14:50:10 worker.2    | started with pid 6125
    14:50:10 worker.3    | started with pid 6128
    14:50:10 worker.4    | started with pid 6131
    14:50:10 scheduler.1 | started with pid 6137
    14:50:10 web.1       | started with pid 6140

It can also export to a set of [Upstart](http://upstart.ubuntu.com/) scripts:

    # foreman export upstart /etc/init
    [foreman export] writing: resque.conf
    [foreman export] writing: resque-worker.conf
    [foreman export] writing: resque-worker-1.conf
    [foreman export] writing: resque-worker-2.conf
    [foreman export] writing: resque-worker-3.conf
    [foreman export] writing: resque-worker-4.conf
    [foreman export] writing: resque-scheduler.conf
    [foreman export] writing: resque-scheduler-1.conf
    [foreman export] writing: resque-web.conf
    [foreman export] writing: resque-web-1.conf

This picks up some values from the [.foreman](https://github.com/theodi/open-orgn-services/blob/feature-53-infrastructure/.foreman) file. Note that we're using the template at [config/foreman/master.conf.erb](https://github.com/theodi/open-orgn-services/blob/feature-53-infrastructure/config/foreman/master.conf.erb) for the master script because the default start conditions didn't seem to work for me. You can control the whole lot with something like ```sudo start resque```.

Next step is to proxy the web interface with nginx, but that's an infrastucture thing.

License
-------

This code is open source under the MIT license. See the LICENSE.md file for 
full details.
