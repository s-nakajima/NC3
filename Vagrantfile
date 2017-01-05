# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  CHEF_ROOT = './tools/chef'.freeze

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = true

  # Setup default vm
  config.vm.define 'default', primary: true do |node|
    config.vm.box = 'NetCommons3-ubuntu'
    config.vm.box_url = 'http://download.nakazii-co.jp/nc3-ubuntu-php55-mysql55-mroonga.box'

    node.vm.network :forwarded_port, guest: 80, host: 9090, auto_correct: true
    node.vm.network :private_network, ip: '10.0.0.10'
    node.vm.hostname = 'app.local'
    node.hostmanager.aliases = %w(
      html.local
    )
    node.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.memory = 4096
    end
    node.vm.synced_folder '.', '/var/www/app', disabled: true,
    #- mac and ubuntu, etc.
    #node.vm.synced_folder '.', '/var/www/app',
    :create => true, :owner=> 'www-data', :group => 'www-data'
  end

  config.vm.define 'default,centos72', primary: true do |node|
    config.vm.box = 'NetCommons3-centos72'
    config.vm.box_url = 'http://download.nakazii-co.jp/nc3-centos72-php70-mysql56.box'
    
    #node.vm.network :forwarded_port, guest: 22, host: 2222, id: 'ssh'
    node.vm.network :forwarded_port, guest: 80, host: 9090, auto_correct: true
    node.vm.network :private_network, ip: '10.0.0.10', auto_config:false
    #node.vm.network :private_network, ip: '10.0.0.10'

    node.vm.hostname = 'app2.local'
    node.hostmanager.aliases = %w(
      html.local app.local phpmyadmin.local
    )
    node.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.memory = 4096
    end

    node.vm.synced_folder '.', '/var/www/app', disabled: true,
    #- mac and ubuntu, etc.
    #node.vm.synced_folder '.', '/var/www/app',
    :create => true, :owner=> 'vagrant', :group => 'vagrant'
  end

  # Setup mysql slave
  config.vm.define 'sdb' do |node|
    config.vm.box = 'NetCommons3-ubuntu'
    config.vm.box_url = 'http://download.nakazii-co.jp/nc3-ubuntu-php55-mysql55-mroonga.box'

    node.vm.network :private_network, ip: '10.0.0.11'
    node.vm.hostname = 'sdb.local'
    node.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.cpus = 1
      vb.memory = 512
    end
    node.vm.synced_folder '.', '/vagrant'
  end

  config.vm.provision :hostmanager
  #config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest
end
