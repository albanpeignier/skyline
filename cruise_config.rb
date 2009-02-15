# Project-specific configuration for CruiseControl.rb

Project.configure do |project|
  
  # Send email notifications about broken and fixed builds to email1@your.site, email2@your.site (default: send to nobody)
  project.email_notifier.emails = ['alban.peignier@free.fr']

  # Set email 'from' field to john@doe.com:
  project.email_notifier.from = 'root@tryphon.org'

  # Build the project by invoking rake task 'custom'
  #project.rake_task = 'cruise'

  # Build the project by invoking shell script "build_my_app.sh". Keep in mind that when the script is invoked,
  # current working directory is <em>[cruise&nbsp;data]</em>/projects/your_project/work, so if you do not keep build_my_app.sh
  # in version control, it should be '../build_my_app.sh' instead
  project.build_command = './script/rake_with_rails_setup cruise'

  # Ping Subversion for new revisions every 5 minutes (default: 30 seconds)
  project.scheduler.polling_interval = 30.minutes

end
