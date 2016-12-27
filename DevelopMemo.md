CentOS7.2のBoxファイル構築メモ
=======

### Box（ゲストOS）の構成
#### 1. NetCommons3-ubuntu（[nc3-ubuntu-php55-mysql55-mroonga.box](http://download.nakazii-co.jp/)）

| ライブラリ | バージョン | 備考
| ------------ | ------ | ------
| OS | Ubuntu 12.04 | Ubuntu 12.04 LTS (GNU/Linux 3.2.0-23-generic x86_64) 
| php | 5.5.23 | PHP 5.5.23-1+deb.sury.org~precise+2 (cli) (built: Mar 24 2015 11:00:01) 
| mysql | 5.5(mroonga) | mysql  Ver 14.14 Distrib 5.5.41, for debian-linux-gnu (x86_64) using readline 6.2

### ホスト側の設定
#### 1. 純粋なBoxファイルを取得する
##### 手順1) https://atlas.hashicorp.com/boxes/search から取得するOSを調べる
##### 手順2) Vagrantfileを下記のように修正する
~~~~
config.vm.box = 'NetCommons3-ubuntu'
config.vm.box_url = 'http://download.nakazii-co.jp/nc3-ubuntu-php55-mysql55-mroonga.box'
~~~~
<br>↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
~~~~
config.vm.box = 'bento/centos-7.2'
~~~~
