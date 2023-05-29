rm /app/tmp/pids/server.pid
rails db:create
rails db:migrate
rails assets:precompile
rails server -b 0.0.0.0 -C --log-to-stdout