namespace :db do

  task :setup do
    # install a default database.yml
    cp database_config_file(:default), database_config_file unless File.exists?(database_config_file)
  end

  def database_config_file(suffix = nil)
    suffix = "_#{suffix}" if suffix
    "#{File.join(RAILS_ROOT, 'config', 'database')}#{suffix}.yml"
  end

end

task :environment => 'db:setup'
