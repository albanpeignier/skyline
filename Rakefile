# -*- coding: undecided -*-
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

# make sure rails and gems will be installed on cruisecontrol server
task ':cc:build' => :setup
require 'vendor/plugins/rails_setup/lib/tasks'

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'
