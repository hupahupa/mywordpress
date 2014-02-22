# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|

    config.vm.box = 'precise32'
    config.vm.box_url = 'http://files.vagrantup.com/precise32.box'  

    config.vm.network :forwarded_port, guest: 80, host: 9260
    config.vm.network :forwarded_port, guest: 22, host: 9261
    
    #config.vm.boot_mode = :gui

    # apt wants the partial folder to be there
    apt_cache = './.cache/apt'
    FileUtils.mkpath "#{apt_cache}/partial"

    chef_cache = '/var/chef/cache'

    shared_folders = {
        apt_cache => '/var/cache/apt/archives',
        './.cache/chef' => chef_cache,
    }

    config.vm.provider :virtualbox do |vb|

        shared_folders.each do |source, destination|
            FileUtils.mkpath source
            config.vm.synced_folder source, destination
            vb.customize ['setextradata', :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/#{destination}", '1']
        end

        vb.customize ['setextradata', :id, 'VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root', '1']
    end


    config.vm.provision :chef_solo do |chef|

        chef.provisioning_path = chef_cache

        chef.cookbooks_path = [
            'chef/chef-cookbooks',
            'chef/site-cookbooks',
        ]

        chef.json = {
            :mywordpress => {
                :admin_email => 'support@vagrant.local',
                :app_user => 'vagrant',                
                :db => {                    
                    :database => 'mywordpress',                    
                    :username => 'mywordpress',
                    :password => 'secret'
                },                      
                :log_dir => '/vagrant/logs',                
                :server_names => ['mywordpress.agilsatel.com'],
                :site_dir => '/vagrant/wordpress',                
            },
            :mysql => {
                :server_root_password => 'secret',
                :server_debian_password => 'secret',
                :server_repl_password => 'secret',
            },            
        }

        chef.add_recipe 'vagrant'    
    end
end
