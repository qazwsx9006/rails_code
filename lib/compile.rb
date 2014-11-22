puts 'tmy:start clobber'

`rails_env=production bundle exec rake assets:clobber`

puts 'tmy:start precompile'

`rails_env=production bundle exec rake assets:precompile`

puts 'tmy:restart apache'

`sudo service nginx restart`

puts 'end