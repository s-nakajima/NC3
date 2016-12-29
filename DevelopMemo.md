CentOS7.2のBoxファイル構築メモ
=======

### 

### Box（ゲストOS）の構成
#### 1. NetCommons3-centos72（[nc3-ubuntu-php55-mysql55-mroonga.box](http://download.nakazii-co.jp/)）

| ライブラリ | バージョン | 備考
| ------------ | ------ | ------
| OS | CentOS 7.2 | CentOS Linux release 7.2.1511 (Core)
| php | 7.0.14 | PHP 7.0.14 (cli) (built: Dec  7 2016 10:15:15) ( NTS )
| mysql | 5.5(mroonga) | mysql  Ver 14.14 Distrib 5.5.41, for debian-linux-gnu (x86_64) using readline 6.2

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
#### 1. httpdのインストール
httpdのインストール
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

#### 2. phpのインストール
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
# yum install --enablerepo=remi,remi-php70 php php-devel php-mbstring php-pdo php-gd
~~~~

##### インストール結果確認
~~~~
# rpm -qa | grep php
# php --version
~~~~

/etc/php.iniの編集
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
<?php phpinfo(); ?>
~~~~

ブラウザで動作確認<br>
http://127.0.0.1:9090/phpinfo.php

#### 3. mysqlのインストール
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

~~~~



