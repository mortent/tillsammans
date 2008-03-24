# Pretty much works with both vlad >= 1.2 and capistrano >= 2.2
# -oc

set :application, "tillsammans"
set :domain,      "tillsammans.boss.bekk.no"
set :repository,  "ssh://git@boss.bekk.no/srv/git/tillsammans/mainline.git"
set :deploy_to,   "/var/www/rails/#{application}"

set :scm,         :git

namespace :vlad do  
  desc "Copy database configuration to release"  
  remote_task :db_config, :roles => :app do  
      run "cp #{shared_path}/database.yml #{release_path}/config/database.yml"  
  end  
   
  task :dpl => [:setup, :update, :db_config, :migrate]
end

set :web_command, "sudo /usr/sbin/apache2ctl"
set :mongrel_port, "3113"
set :mongrel_servers, "1"
