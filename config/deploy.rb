# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'yq'
set :repository, 'git@github.com:felippefpiazza/yq.git'
set :base_path, '/var/www'
role :web, "104.131.233.143"
role :app, "104.131.233.143"
role :db, "104.131.233.143", :primary => true

#####################################################################
#### normally two deployment environments ###########################
#####################################################################

set :targets, {
  teste:      'test',
  production: 'prod'
}

targets.each do |target, app|
  task target.to_sym do
    set :app_namespace, "#{application}_#{app}"
    set :deploy_to, "#{base_path}/#{app_namespace}"
  end
end

#####################################################################
#### there shouldnt be any need to change things below this line ####
#####################################################################

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :rvm_ruby_string, '2.1.2'
set :rvm_type, :system 
set :scm, :git
set :deploy_via, :export
set :use_sudo, false
set :user, "felippe"


#set :rails_env, "production"
#set :keep_releases, 5



namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
