task :cruise => [ 'db:test:purge', 'db:migrate', 'log:clear', :spec ]
