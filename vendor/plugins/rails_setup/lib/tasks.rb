plugin_dir="#{File.dirname(__FILE__)}/.."

lib_dir = "#{plugin_dir}/lib"
$: << lib_dir unless $:.include?(lib_dir)

require 'rails_setup'

load "#{plugin_dir}/tasks/rails_setup_tasks.rake"

if RailsSetup.rails_install_task_invoked?
  # Kernel.gem will install rails gem if needed
  require 'rubygems'
  module Kernel
    alias_method :orig_gem, :gem
    
    def gem(name, *version_requirements)
      unless 'rails' == name
        orig_gem(name, *version_requirements)
      else
        begin
          orig_gem('rails', *version_requirements)
        rescue Gem::LoadError
          RailsSetup.gem_install(version_requirements.first)
          Gem::refresh
          orig_gem('rails', *version_requirements)
        end
      end
    end
  end
end
