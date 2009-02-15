desc "Install required dependencies (Rails, Gems ...)"
task :setup => ['rails:install', 'gems:install_with_sudo']

namespace :gems do

  task :use_sudo do
    class Rails::GemDependency
      # use sudo to install 
      def gem_command; 'sudo gem'; end
    end
  end

  desc "Installs with sudo all required gems for this rails application"
  task :install_with_sudo => [ 'use_sudo', 'gems:install']

end

namespace :rails do

  desc "Installs the required rails gem"
  task :install do
    # real action is performed by Kernel.gem
    # if this task is present in Rake prerequisites
  end

end
