# -*- mode: ruby -*-
# vi: set ft=ruby :

instance_hostname = "rheltest"
rhn_username = ENV['RHNUSERNAME'] # add your RHN credentials in env variables...
rhn_password = ENV['RHNPASSWORD']

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  # rhel65 is a box made with Packer using Opscode's bento : https://github.com/opscode/bento
  config.vm.box = "rhel65"
  
  # https://github.com/emyl/vagrant-triggers
  if Vagrant.has_plugin?("vagrant-triggers")
    # Registering with RHN after the machine is up
    config.trigger.after [:resume, :reload], :stdout => true do
      info "Registering with Red Hat Network"
      run_remote "sudo /usr/bin/subscription-manager register --username #{rhn_username} --password #{rhn_password} --auto-attach --force"
    end
  end
  
  # https://github.com/fgrehm/vagrant-cachier
  if Vagrant.has_plugin?("vagrant-cachier")
    # Caching yum packages if possible
    config.cache.scope = :box
  end
  
  # https://github.com/smdahlen/vagrant-hostmanager
  if Vagrant.has_plugin?("vagrant-hostmanager")
    # setting up hostname in /etc/hosts on the host and the instances of the vagrantfile!
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true
  end
  
  config.vm.define 'rhel65test' do |rhel|
    rhel.vm.synced_folder ".", "/vagrant", type: "nfs"
    rhel.vm.hostname = instance_hostname
    rhel.hostmanager.aliases = ["#{instance_hostname}.test.local"]
    rhel.vm.provision "shell", inline: "/usr/bin/subscription-manager register --username #{rhn_username} --password #{rhn_password} --auto-attach --force"
    rhel.vm.provision "shell", inline: "yum update yum -y"
    rhel.vm.provision "shell", inline: "yum update -y"
    
    # ...
    # ... add your own provisionning ...
    # ...
  end
  
  if Vagrant.has_plugin?("vagrant-triggers")
    # Unregistering with RHN before the machine is being destroyed
    config.trigger.before [:halt, :suspend, :destroy], :stdout => true, :force => true do
      info "Unregistering from Red Hat Network"
      run_remote "sudo /usr/bin/subscription-manager unregister"
    end
  end
end
