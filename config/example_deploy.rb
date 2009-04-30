set :runner, 'example'
set :use_sudo, false

# Custom Options
set :user, 'example'
set :application, 'example.com'
set :domain, 'example.com'
set :alias, %{ example.com }

role :app, domain
role :web, domain
role :db, domain, :primary => true

# Database Options
set :rails_env, 'production'

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/#{user}/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git
set :deploy_via, :copy
set :repository, "."
set :copy_exclude, %w(.git test .DS_Store)
set :copy_cache, true

default_run_options[:pty] = true
ssh_options[:paranoid] = false
ssh_options[:keys] = %w(/path/to/ssh/keys/.ssh/id_rsa)
ssh_options[:port] = 12345

after "deploy:finalize_update", "uploads:symlink"
after "deploy", "deploy:cleanup"
after "deploy", "thin:stop"
after "thin:stop", "thin:start"

namespace :uploads do
  desc "Make symlink for image uploads"
  task :symlink do
    run "ln -nfs #{shared_path}/public/images/items/ #{release_path}/public/images/items"
  end
end

namespace :thin do
  %w(start stop restart).each do |action|
  desc "#{action} this app's Thin Cluster"
    task action.to_sym, :roles => :app do
      sudo "/etc/init.d/thin #{action}"
    end
  end
end