set :application, 'ssocc'
# set :repo_url, 'git@example.com:me/my_repo.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :branch, "master"

# set :deploy_to, '/appl/oracle/iam-apps/test'
set :scm, :git

# set :format, :pretty
set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "$HOME/.rbenv/bin:$PATH" }

# set :keep_releases, 5

# unicorn
#
set :rails_env, :production
set :unicorn_binary, "#{current_path}/bin/unicorn"
#set :unicorn_config, "#{current_path}/config/unicorn/#{stage_set}.rb"
set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"

set :linked_dirs, %w{log tmp/pids tmp/sockets}

namespace :deploy do
  
  # unicorn hooks
  before 'deploy:published','control:restart'
  before 'control:restart','util:kill_old'
  

  after :finishing, 'deploy:cleanup'
  # desc 'Start application'
  # task :start, :roles => :app, :except => { :no_release => true } do 
  #   run "cd #{current_path} && #{unicorn_binary} -c #{unicorn_config} -E #{rails_env} -D"
  # end

  # desc 'Stop application'
  # task :stop,  :roles => :app, :except => { :no_release => true } do 
  #   run "kill `cat #{unicorn_pid}`"
  # end
  #
  # desc 'Gracefl stop application'
  # task :graceful_stop, :roles => :app, :except => { :no_release => true } do
  #   run "#{try_sudo} kill -s QUIT `cat #{unicorn_pid}`"
  # end
  # desc 'Reload application'
  # task :reload, :roles => :app, :except => { :no_release => true } do
  #   run "#{try_sudo} kill -s USR2 `cat #{unicorn_pid}`"
  # end
  # desc 'Restart application'
  # task :restart, :roles => :app, :except => { :no_release => true } do
  #   stop
  #   start
  # end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
  #    # Your restart mechanism here, for example:
  #    # execute :touch, release_path.join('tmp/restart.txt')
  #    # run "kill `cat #{unicorn_pid}`"
  #    # run "cd #{current_path} && #{unicorn_binary} -c #{unicorn_config} -E #{rails_env} -D"
    end
  end
  
#  before (:started) do
#    on roles(:app) do
#    
#        # configure local variables
#        unicorn_pid="#{current_path}/tmp/pids/unicorn.pid"
#        
#        puts "unicorn pid: "
#        execute "cat #{unicorn_pid}"
#    end
#  end

  # after :restart, :clear_cache do
  #   on roles(:web), in: :groups, limit: 3, wait: 10 do
  #     # Here we can do anything such as:
  #     # within release_path do
  #     #   execute :rake, 'cache:clear'
  #     # end
  #   end
  # end

end
