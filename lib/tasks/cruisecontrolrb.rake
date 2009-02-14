task :cruise => [ :setup, 'db:test:purge', 'db:migrate', 'log:clear', :spec ]
