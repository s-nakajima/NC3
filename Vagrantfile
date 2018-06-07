# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = true

  config.vm.define 'default', primary: true do |node|
    #node.vm.box = 'bento/centos-7.1'

    #node.vm.box = 'nc3-centos71-php55'
    #node.vm.box_url = 'http://download.nakazii-co.jp/nc3-centos71-php55.json'

    node.vm.box = 'nc3-centos71-php70'
    node.vm.box_url = 'http://download.nakazii-co.jp/nc3-centos71-php70.json'

    node.vm.network :forwarded_port, guest: 22, host: 2222, id: 'ssh'
    node.vm.network :forwarded_port, guest: 22, host: 2224, id: 'ssh'
    node.vm.network :forwarded_port, guest: 80, host: 9090, auto_correct: true
    node.vm.network :forwarded_port, guest: 80, host: 9094, auto_correct: true
    node.vm.network :private_network, ip: '10.0.0.14', auto_config:false
    #node.vm.network :private_network, ip: '10.0.0.14'

    node.vm.hostname = 'app.local'
    node.hostmanager.aliases = %w(
      html.local app.local phpmyadmin.local
    )
    node.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.memory = 4096
    end

    node.vm.synced_folder '.', '/var/www/app', disabled: true,
    :create => true, :owner=> 'vagrant', :group => 'vagrant'
  end

#  # Setup default vm
#  config.vm.define 'default', primary: true do |node|
#    node.vm.box = 'NetCommons3-ubuntu'
#    node.vm.box_url = 'http://download.nakazii-co.jp/nc3-ubuntu-php55-mysql55-mroonga.box'
#
#    node.vm.network :forwarded_port, guest: 80, host: 9090, auto_correct: true
#    node.vm.network :private_network, ip: '10.0.0.10'
#    node.vm.hostname = 'app.local'
#    node.hostmanager.aliases = %w(
#      html.local
#    )
#    node.vm.provider :virtualbox do |vb|
#      vb.gui = false
#      vb.memory = 4096
#    end
#    node.vm.synced_folder '.', '/var/www/app', disabled: true,
#    #- mac and ubuntu, etc.
#    #node.vm.synced_folder '.', '/var/www/app',
#    :create => true, :owner=> 'www-data', :group => 'www-data'
#  end
#
#  # Setup mysql slave
#  config.vm.define 'sdb' do |node|
#    config.vm.box = 'NetCommons3-ubuntu'
#    config.vm.box_url = 'http://download.nakazii-co.jp/nc3-ubuntu-php55-mysql55-mroonga.box'
#
#    node.vm.network :private_network, ip: '10.0.0.11'
#    node.vm.hostname = 'sdb.local'
#    node.vm.provider :virtualbox do |vb|
#      vb.gui = false
#      vb.cpus = 1
#      vb.memory = 512
#    end
#    node.vm.synced_folder '.', '/vagrant'
#  end

  config.vm.provision :hostmanager
  #config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest
end
