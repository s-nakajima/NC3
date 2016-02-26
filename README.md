NetCommons環境構築ツール
=======

このツールは、正規のNetCommons3開発環境の構築とは異なり、2016.02.28現在、中島が開発環境で使用してるものから開発環境を構築するツールです。 

## NetCommonsとは
国立情報学研究所が次世代情報共有基盤システムとして開発しています。サポート情報やライセンスなどの最新の情報は公式サイトを御覧ください。
こちらのリポジトリは最新版として開発中のv3となります。安定版ではありませんのでご注意ください。現在の安定版については[こちらのレポジトリ](https://github.com/netcommons)をご覧ください。


## 動作実績

以下の組み合わせで動作することを確認しています。

| OS           | matrix |
| ------------ | ------ |
| Windows 10  | virtualbox 5.0.12, vagrant 1.8.0 |

### ゲストOSの構成

| ライブラリ | バージョン | 備考
| ------------ | ------ | ------
| php | 5.5.23 | PHP 5.5.23-1+deb.sury.org~precise+2 (cli) (built: Mar 24 2015 11:00:01) 
| mysql | 5.5(mroonga) | mysql  Ver 14.14 Distrib 5.5.41, for debian-linux-gnu (x86_64) using readline 6.2


## インストール
### 共通
下記アプリケーションをインストールして下さい。

* virtualbox
  * [https://www.virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads)
* vagrant
  * [http://www.vagrantup.com/downloads.html](http://www.vagrantup.com/downloads.html)<br>
Windows ホストの場合、vagrant は 管理者権限が必要なフォルダ（Program Files 等）にはインストールしないようにしてください。vagrant 起動時にエラーが発生します。

* chef-dk
  * [https://downloads.getchef.com/chef-dk](https://downloads.getchef.com/chef-dk)

#### Windwosの場合
* Git for windows
  * [https://git-for-windows.github.io/](https://git-for-windows.github.io/)<br>
gitコマンドにパスを通す必要がある。


### 依存ライブラリのインストール
#### Windoswの場合

##### synced_folder 無効化
virtualbox のある時点から Windows では synced_folder 上で symlink が貼れなくなっています。  
synced_folder を有効にしたままで vagrant up すると symlink が破壊されます。下記の通り Vagrantfile に 『disabled: true』 を指定して下さい。

```
node.vm.synced_folder '.', '/var/www/app',
:create => true, :owner=> 'www-data', :group => 'www-data'
```
↓
```
node.vm.synced_folder '.', '/var/www/app', disabled: true,
:create => true, :owner=> 'www-data', :group => 'www-data'
```

##### install.batの実行
install.batには、下記vagrant pluginも含めインストールします。

#### それ以外（共通）
##### vagrant plugin
```
vagrant plugin install vagrant-hostmanager
vagrant plugin install vagrant-omnibus
```

##### vagrant を起動
配置したソースのパスで vagrant を起動します。初回のみ OS のダウンロードに時間がかかります。

```
vagrant up default
```

## その他
### 終了
vagrantコマンドで仮想マシンを終了、又は破棄できます。

* 一旦止めるだけの場合

```
vagrant halt
```

* データを破棄する場合
次回、`vagrant up` の際にはまっさらなマシンから新規インストールが行われます。

```
vagrant destroy
```

* provision する場合
 default オプションをつける必要があります。

```
vagrant provision default
```
