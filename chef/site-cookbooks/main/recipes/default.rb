include_recipe 'apt'
include_recipe 'mysql::server'
include_recipe 'apache2'
include_recipe 'apache2::mod_php5'
include_recipe 'php'
include_recipe 'php::module_curl'
include_recipe 'php::module_mysql'

#DB init
include_recipe "main::database"

#template init
template "#{node[:mywordpress][:site_dir]}/wp-config.php" do
    source 'wp-config.php.erb'
end

#create folder
directory node[:mywordpress][:log_dir] do
    action :create
    recursive true
end

#virtual host init
template '/etc/apache2/sites-available/mywordpress' do
    source 'apache-site.erb'
    mode '0644'
end

#en and disable site
apache_site '000-default' do
    action :disable
end

apache_site 'mywordpress' do
    action :enable
end

#bash files
template "#{node[:mywordpress][:site_dir]}/scripts/set_env.sh" do
    source 'set_env.sh.erb'
    mode '0655'
end