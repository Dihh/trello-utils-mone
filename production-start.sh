git pull
bundle install
rm /app/tmp/pids/server.pid
rails db:migrate
rails assets:precompile
rails server -b 0.0.0.0 -C --log-to-stdout