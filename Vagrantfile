# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = true
  config.ssh.insert_key = false

  config.vm.define 'default', primary: true do |node|
    #node.vm.box = 'bento/centos-7.1'

    #node.vm.box = 'nc3-centos71-php5'
    #node.vm.box_url = 'http://download.nakazii-co.jp/nc3-centos71-php5.json'

    node.vm.box = 'nc3-centos71-php72'
    node.vm.box_url = 'http://nc3packages.nakazii-co.jp/nc3-centos71-php72.json'

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

    node.vm.synced_folder './tools', '/var/www/vagrant',
    :create => true, :owner=> 'vagrant', :group => 'vagrant'
    node.vm.provision "shell", privileged: false, inline: <<-SHELL
        GITNAME=""         #<-- GithubのID
        GITPW=""           #<-- Githubのパスワード
        GITMAIL=""         #<-- Githubのメールアドレス
        COMPOSERTOKEN=""   #<-- Githubのアクセストークン(https://github.com/settings/tokens)

        if [ ! "$GITNAME" = "" ] ; then
            git config --global user.name "$GITNAME"
            git config --global url."https://".insteadOf git://
        fi
        if [ ! "$GITMAIL" = "" ] ; then
            git config --global user.email "$GITMAIL"
        fi
        if [ ! "$COMPOSERTOKEN" = "" ] ; then
            composer config -g github-oauth.github.com "$COMPOSERTOKEN"
            composer config --global github-protocols https
        fi
        if [ ! -f /home/vagrant/.netrc -a ! "$GITNAME" = "" -a ! "$GITPW" = "" ]; then
            cat << NETRC > /home/vagrant/.netrc
#Settings to omit login with git command
machine github.com
login $GITNAME
password $GITPW
NETRC
            composer config --global github-protocols https
            git config --global url."https://".insteadOf git://
        fi
SHELL

  end

  config.vm.provision :hostmanager
  #config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest
end
