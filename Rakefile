# -*- coding: undecided -*-
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

load 'lib/tasks/setup.rake'

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

unless RailsSetup.pending?
  require(File.join(File.dirname(__FILE__), 'config', 'boot'))
  require 'tasks/rails'
end

