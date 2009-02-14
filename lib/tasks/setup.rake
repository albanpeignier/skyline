desc "Install required dependencies (Rails, Gems ...)"
task :setup => 'rails:install' do
  new_rake 'gems:install_with_sudo'

  # run other tasks in a new rake
  pending_tasks = Rake.application.top_level_tasks - %w(setup)
  unless pending_tasks.empty?
    exit new_rake pending_tasks
  end
end

def new_rake(*tasks)
  sh "rake #{tasks.join(' ')}"
end

namespace :gems do

  task :use_sudo do
    class Rails::GemDependency
      # use sudo to install 
      def gem_command; 'sudo gem'; end
    end
  end

  task :install_with_sudo => [ 'use_sudo', 'gems:install']

end

namespace :rails do

  task :install do
    RailsSetup.execute
  end

end

require 'rubygems'
module RailsSetup

  def self.pending?
    required? and
      not (Rake.application.top_level_tasks & %w{setup rails:install}).empty?
  end

  def self.required?
    not gem_installed? name, gem_version
  end

  def self.execute
    gem_install_if_needed 'rails', gem_version      
  end

  private

  def self.gem_installed?(name, version = nil)
    not Gem.source_index.find_name(name, version).empty?
  end

  def self.gem_install_if_needed(name, version = nil)
    return if gem_installed? name, version

    cmd = "gem install #{name}"
    cmd << " --version #{version}" if version
    sh "sudo #{cmd}"
  end

  # related boot.rb code can't be used :(

  def self.gem_version
    if defined? RAILS_GEM_VERSION
      RAILS_GEM_VERSION
    elsif ENV.include?('RAILS_GEM_VERSION')
      ENV['RAILS_GEM_VERSION']
    else
      parse_gem_version(read_environment_rb)
    end
  end

  def self.parse_gem_version(text)
    $1 if text =~ /^[^#]*RAILS_GEM_VERSION\s*=\s*["']([!~<>=]*\s*[\d.]+)["']/
  end
  
  def self.read_environment_rb
    File.read("#{File.dirname(__FILE__)}/../../config/environment.rb")
  end

end

