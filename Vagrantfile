# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
    config.vm.synced_folder ".", "/vagrant", mount_options: ["dmode=700,fmode=600"], type: "virtualbox"
  else
    config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  end

  (1..3).each do |i|
    config.vm.define "swarm-worker-0#{i}" do |d|
      d.vm.box = "centos/7"
      d.vm.hostname = "swarm-worker-0#{i}"
      d.vm.network "private_network", ip: "10.100.192.20#{i}"
      d.vm.provider "virtualbox" do |v|
        v.memory = 1024
      end
    end
  end

  config.vm.define "swarm-manager" do |d|
    d.vm.box = "centos/7"
    d.vm.hostname = "swarm-manager"
    d.vm.network "private_network", ip: "10.100.192.200"
    d.vm.provision :shell, path: "scripts/bootstrap_ansible.sh"
    d.vm.provision :shell, inline: "PYTHONUNBUFFERED=1 ansible-playbook /vagrant/ansible/playbook.yml -i /vagrant/ansible/hosts/swarm"
    d.vm.provider "virtualbox" do |v|
      v.memory = 1024
    end
  end

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

end
