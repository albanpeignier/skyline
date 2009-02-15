module RailsSetup

  def self.rails_install_task_invoked?
    Rake.application.top_level_tasks.any? do |task_name|
      depends_on_rails_install?(task_name)
    end
  end

  def self.gem_install(version)
    cmd = "gem install rails"
    cmd << " --version #{version}" if version
    sh "sudo #{cmd}"
  end

  private

  def self.depends_on_rails_install?(task_name)
    return true if task_name == 'rails:install'
    Rake::Task[task_name].prerequisites.any? { |p| depends_on_rails_install? p }
  rescue
    false
  end

end

