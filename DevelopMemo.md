CentOS7.2のBoxファイル構築メモ
=======

### 

### Box（ゲストOS）の構成
#### 1. NetCommons3-centos72（[nc3-ubuntu-php55-mysql55-mroonga.box](http://download.nakazii-co.jp/)）

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

##### サーバを再起動する

##### SELinuxが無効になっていることを確認
~~~~
# getenforce
~~~~


#### 3. NetWorkの設定
##### 設定前の現状確認
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

##### IPアドレスの設定
~~~~
# nmcli c mod enp0s8 ipv4.addresses 10.0.0.10/24
~~~~


#### 4. httpdのインストール
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
# cp -pf /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.dist
# vi /etc/httpd/conf/httpd.conf

各自必要に応じて編集する
~~~~


#### 5. mysqlのインストール
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
~~~~

##### php-mysqlのインストール
~~~~
# yum install --enablerepo=remi --enablerepo=remi-php70 php-mysql
~~~~


#### 6. phpのインストール
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
# yum install --enablerepo=remi,remi-php70 php php-devel php-mbstring php-pdo php-gd php-pear php-mysql php-pecl-xdebug 
~~~~

##### インストール結果確認
~~~~
# rpm -qa | grep php
# php --version
~~~~

##### /etc/php.iniの編集
~~~~
# cp -pf /etc/php.ini /etc/php.ini.dist
# vi /etc/php.ini

各自必要に応じて編集する
~~~~

##### httpdを再起動する
~~~~
systemctl restart httpd
~~~~

##### /var/www/html/phpinfo.phpファイルを生成する
~~~~
# vi /var/www/html/phpinfo.php
~~~~

/var/www/html/phpinfo.php
~~~~
<?php phpinfo(); ?>
~~~~

##### ブラウザで動作確認
http://127.0.0.1:9090/phpinfo.php

##### phpからMySQLの接続できるか確認
~~~~
# vi /var/www/html/mysql.php
~~~~

/var/www/html/mysql.php
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


#### 7. sambaのインストール
##### sambaのインストール
~~~~
# yum -y install samba
~~~~

##### /etc/samba/smb.confの編集
~~~~
# cp -pf /etc/samba/smb.conf /etc/samba/smb.conf.dist
# vi /etc/samba/smb.conf

各自必要に応じて編集する
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

#### 8. composerのインストール
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

#### 9. gitのインストール
~~~~
# yum install git
~~~~

#### 10. bowerのインストール
##### npmのインストール
~~~~
# yum install nodejs npm
# node -v
~~~~

##### bowerのインストール
~~~~
# npm install bower -g
~~~~
