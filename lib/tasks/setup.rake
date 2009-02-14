desc "Install required dependencies (Rails, Gems ...)"
task :setup => [ 'rails:install', 'gems:install_with_sudo']
  
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
    if version = gem_version
      gem_install_if_needed 'rails', version
    else
      gem_install_if_needed 'rails'
    end
  end

  def gem_installed?(name, version = nil)
    not Gem.source_index.find_name(name, version).empty?
  end

  def gem_install_if_needed(name, version = nil)
    return if gem_installed? name, version

    cmd = %w(install) << name
    cmd << "--version" << %("#{version.to_s}") if version
    sh "sudo ${cmd}"
  end

  # related boot.rb code can't be used :(

  def gem_version
    if defined? RAILS_GEM_VERSION
      RAILS_GEM_VERSION
    elsif ENV.include?('RAILS_GEM_VERSION')
      ENV['RAILS_GEM_VERSION']
    else
      parse_gem_version(read_environment_rb)
    end
  end

  def parse_gem_version(text)
    $1 if text =~ /^[^#]*RAILS_GEM_VERSION\s*=\s*["']([!~<>=]*\s*[\d.]+)["']/
  end
  
  def read_environment_rb
    File.read("#{RAILS_ROOT}/config/environment.rb")
  end

end
