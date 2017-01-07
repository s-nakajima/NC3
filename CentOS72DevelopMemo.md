CentOS7.2のBoxファイル構築メモ
=======

### 

### Box（ゲストOS）の構成
#### 1. NetCommons3-centos72（[nc3-centos72-php70-mysql56.box](http://download.nakazii-co.jp/)）

| ライブラリ | バージョン | 備考
| ------------ | ------ | ------
| OS | CentOS 7.2 | CentOS Linux release 7.2.1511 (Core)
| php | 7.0.14 | PHP 7.0.14 (cli) (built: Dec  7 2016 10:15:15) ( NTS )
| mysql | 5.6.35 | mysqld  Ver 5.6.35 for Linux on x86_64 (MySQL Community Server (GPL))

### ホスト側の設定
#### 1. 純粋なBoxファイルを取得する
##### 手順1) https://atlas.hashicorp.com/boxes/search から取得するOSを調べる
##### 手順2) Vagrantfileを下記のように修正する
~~~~
config.vm.box = 'NetCommons3-ubuntu'
config.vm.box_url = 'http://download.nakazii-co.jp/nc3-ubuntu-php55-mysql55-mroonga.box'

↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

config.vm.box = 'bento/centos-7.2'
~~~~

#### 2. Boxファイルの作成
##### ボックスファイルの作成
~~~~
# box 作成用のフォルダ(任意)に移動します。
> cd xxxx(box 作成用のフォルダ)

# --base：作成対象の仮想マシン名、--output：出力 box ファイル名
> vagrant package
~~~~

##### ファイル名を変更する
~~~~
nc3-centos72-php70-mysql56.box
~~~~

##### ボックスファイルをアップロードする
~~~~
http://download.nakazii-co.jp/nc3-centos72-php70-mysql56.box
~~~~

##### Vagrantfileを下記のように修正する
~~~~
config.vm.box = 'bento/centos-7.2'

↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

config.vm.box = 'NetCommons3-centos72'
config.vm.box_url = 'http://download.nakazii-co.jp/nc3-centos72-php70-mysql56.box'
~~~~


### ゲスト側の設定
#### 1. ファイアウォールをdisableにする
~~~~
# systemctl stop firewalld
# systemctl disable firewalld
~~~~

#### 2. SELinuxをdisabledにする
##### /etc/selinux/configを編集する
~~~~
# cp -pf /etc/selinux/config /etc/selinux/config.dist
# vi /etc/selinux/config
~~~~

/etc/selinux/config
~~~~
SELINUX=disabled
~~~~

#### 3. sshの設定
##### /etc/selinux/configを編集する
~~~~
# mv /etc/ssh/ssh_config /etc/ssh/ssh_config.dist
# cp /home/vagrant/default/ssh/ssh_config /etc/ssh/

# mv /etc/ssh/sshd_config /etc/ssh/sshd_config.dist
# cp /home/vagrant/default/ssh/sshd_config /etc/ssh/
# chown root:root /etc/ssh/sshd_config
# chmod 600 /etc/ssh/sshd_config
~~~~

/etc/selinux/config
~~~~
SELINUX=disabled
~~~~

##### サーバを再起動する

##### SELinuxが無効になっていることを確認
~~~~
# getenforce
~~~~


#### 4. NetWorkの設定
##### CentOS7からeth0からenp0s3という形になったため、Vagrantfileを下記のように変更して実行する
Vagrantfile
~~~~
#node.vm.network :private_network, ip: '10.0.0.10', auto_config:false
node.vm.network :private_network, ip: '10.0.0.10'
~~~~

##### 再度Vagrantfileを下記のように変更して実行する
Vagrantfile
~~~~
node.vm.network :private_network, ip: '10.0.0.10', auto_config:false
#node.vm.network :private_network, ip: '10.0.0.10'
~~~~

##### IPアドレスの確認
~~~~
# ifconfig
enp0s3: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.2.15  netmask 255.255.255.0  broadcast 10.0.2.255
        inet6 fe80::a00:27ff:fe5a:e9e7  prefixlen 64  scopeid 0x20<link>
        ether 08:00:27:5a:e9:e7  txqueuelen 1000  (Ethernet)
        RX packets 220  bytes 25170 (24.5 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 208  bytes 31786 (31.0 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

enp0s8: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.0.10  netmask 255.255.255.0  broadcast 10.0.0.255
        inet6 fe80::a00:27ff:fe26:10d9  prefixlen 64  scopeid 0x20<link>
        ether 08:00:27:26:10:d9  txqueuelen 1000  (Ethernet)
        RX packets 3  bytes 407 (407.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 35  bytes 3509 (3.4 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 0  (Local Loopback)
        RX packets 4  bytes 240 (240.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 4  bytes 240 (240.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
~~~~

#### ネット関係のコマンド(ifconfig,nslookupなど)を入れる
~~~~
# yum install -y net-tools bind-utils
~~~~

#### 5. httpdのインストール
##### httpdのインストール
~~~~
# yum -y install httpd
# httpd -v
Server version: Apache/2.4.6 (CentOS)
Server built:   Nov 14 2016 18:04:44
~~~~

##### httpdの起動
~~~~
# systemctl start httpd
~~~~

##### ブラウザで確認<br>
http://127.0.0.1:9090

##### httpdの停止
~~~~
# systemctl stop httpd 
~~~~

##### httpdの自動起動
~~~~
# systemctl enable httpd
# systemctl is-enabled httpd
enabled
~~~~~

##### /etc/httpd/conf/httpd.confの編集
~~~~
# mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.dist
# cp /home/vagrant/default/httpd/httpd.conf /etc/httpd/conf/
# cp /home/vagrant/default/httpd/conf.d/app.conf /etc/httpd/conf.d/
# cp /home/vagrant/default/httpd/conf.d/html.conf /etc/httpd/conf.d/
# cp /home/vagrant/default/httpd/conf.d/phpmyadmin.conf /etc/httpd/conf.d/
~~~~


#### 6. mysqlのインストール
##### MySQLリポジトリの追加
~~~~
# yum localinstall http://dev.mysql.com/get/mysql57-community-release-el6-7.noarch.rpm
# yum repolist all | grep mysql

※有効になっているmysqlのバージョンを確認。mysql5.6になっていなければ、mysql5.6を有効にする

# yum -y install yum-utils
# yum-config-manager --disable mysql57-community
# yum-config-manager --enable mysql56-community
# yum repolist all | grep mysql
~~~~

##### 利用できる MySQL Community Server の確認
~~~~
# yum info mysql-community-server
~~~~

##### MySQL Community Server のインストール
~~~~~
# yum -y install mysql-community-server
~~~~~

##### MySQL Server の確認
~~~~~
# mysqld --version
mysqld  Ver 5.6.35 for Linux on x86_64 (MySQL Community Server (GPL))
~~~~~

##### mysqldの起動
~~~~
# systemctl start mysqld
~~~~

##### mysqldの停止
~~~~
# systemctl stop mysqld
~~~~

##### mysqldの自動起動
~~~~
# systemctl enable mysqld
# systemctl is-enabled mysqld
enabled
~~~~

##### root ユーザーのパスワード設定
~~~~
# mysqladmin -u root password 'root'
# mysql -uroot -proot
mysql> set password for root@'127.0.0.1' = password('root');
~~~~

##### my.cnfの修正
~~~~
# mv /etc/my.cnf /etc/my.cnf.dist
# cp /home/vagrant/default/mysql/my.cnf /etc/
~~~~


#### 7. phpのインストール
##### EPELリポジトリの追加
~~~~
# yum install epel-release
~~~~

##### remiレポジトリの追加
~~~~
# rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
~~~~

##### PHP7.0をインストール
~~~~
# yum install --enablerepo=remi,remi-php70 php php-devel php-mbstring php-pdo php-gd php-pear php-mysql php-pecl-xdebug php-mcrypt
~~~~

##### インストール結果確認
~~~~
# rpm -qa | grep php
# php --version
~~~~

##### /etc/php.iniの編集
~~~~
# mv /etc/php.ini /etc/php.ini.dist
# cp /home/vagrant/default/php/php.ini /etc/
~~~~

##### /var/lib/php/sessionのパーミッション変更
~~~~
# cd /var/lib/php/session
# chgrp -R vagrant .
~~~~

##### httpdを再起動する
~~~~
# systemctl restart httpd
~~~~

##### ImageMagickのインストール
~~~~
# yum install ImageMagick ImageMagick-devel ImageMagick-perl
# yum install gcc
# pecl install imagick
~~~~

##### /var/www/phpinfo.phpファイルを生成する
~~~~
# cp /home/vagrant/default/php/phpinfo.php /var/www/app/
~~~~

##### ブラウザで動作確認
http://127.0.0.1:9090/phpinfo.php

##### phpからMySQLの接続できるか確認
~~~~
# cp /home/vagrant/default/php/mysql.php /var/www/app/
~~~~

/var/www/mysql.php
~~~~
<?php
$db = new PDO(
	sprintf('%s:host=%s;port=%s', 'mysql', 'localhost', '3306'),
	'root',
	'root'
);
$result = $db->query('SET NAMES utf8;');
echo 'Success to MySQL connect.';
~~~~
http://127.0.0.1:9090/mysql.php


#### 8. sambaのインストール
##### sambaのインストール
~~~~
# yum -y install samba
~~~~

##### /etc/samba/smb.confの編集
~~~~
# mv /etc/samba/smb.conf /etc/samba/smb.conf.dist
# cp /home/vagrant/default/samba/smb.conf /etc/samba/
~~~~

##### smbを再起動する
~~~~
# systemctl restart smb
# systemctl restart nmb
~~~~

##### smbの自動起動
~~~~
# systemctl enable smb
# systemctl enable nmb

# systemctl is-enabled smb
enabled
# systemctl is-enabled nmb
enabled
~~~~

#### 9. composerのインストール
##### ダウンロード
~~~~
# curl -sS https://getcomposer.org/installer | php
~~~~

##### パスの確認
~~~~
# echo $PATH
/sbin:/bin:/usr/sbin:/usr/bin
~~~~

##### パスが通っている場所にリネーム
~~~~
# mv composer.phar /usr/bin/composer
~~~~

#### 10. gitのインストール
~~~~
# yum install git
~~~~

#### 11. bowerのインストール
##### npmのインストール
~~~~
# yum install nodejs npm
# node -v
~~~~

##### bowerのインストール
~~~~
# npm install bower -g
# bower -v
~~~~

#### 12. zipのインストール
##### zipのインストール
~~~~
# yum install zip
~~~~

##### unzipのインストール
~~~~
# yum install unzip
~~~~

#### 13. phpMyAdminのインストール
~~~~
# yum install --enablerepo=remi,remi-php70 phpMyAdmin
# cd /var/www/
# wget https://files.phpmyadmin.net/phpMyAdmin/4.6.5.2/phpMyAdmin-4.6.5.2-all-languages.zip
# unzip phpMyAdmin-4.6.5.2-all-languages.zip
# mv phpMyAdmin-4.6.5.2-all-languages phpMyAdmin
# rm -f phpMyAdmin-4.6.5.2-all-languages.zip
~~~~

#### 14. travisのインストール
~~~~
# yum -y install gem
# yum -y install ruby-devel
# gem install travis
~~~~

#### 15. テストを実行させるための設定
##### phpmd.xmlをセット
~~~~
# cp -R /home/vagrant/default/phpmd /etc/
~~~~

##### pipのインストール
~~~~
# yum install python-pip
# pip install six
~~~~

##### pear等をのインストール
~~~~
# cd /var/www/
# git clone https://github.com/s-nakajima/MyShell.git
# cd /var/www/MyShell/nc3PluginTest
# bash nc3PluginTest.sh pear_install
~~~~

