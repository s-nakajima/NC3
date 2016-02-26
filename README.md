NetCommons環境構築ツール
=======

このツールは、正規のNetCommons3開発環境の構築とは異なり、2016.02.28現在、中島が開発環境で使用してるものから作成するツールです。 

## NetCommonsとは
国立情報学研究所が次世代情報共有基盤システムとして開発しています。サポート情報やライセンスなどの最新の情報は公式サイトを御覧ください。
こちらのリポジトリは最新版として開発中のv3となります。安定版ではありませんのでご注意ください。現在の安定版については[こちらのレポジトリ](https://github.com/netcommons)をご覧ください。


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

```

```

#### 共通
##### vagrant plugin
```
vagrant plugin install vagrant-hostmanager
vagrant plugin install vagrant-omnibus
```
##### vagrant plugin (vagrant 1.4.x)
```
vagrant plugin install vagrant-berkshelf --plugin-version 1.3.7
```

##### vagrant plugin (vagrant 1.5.x 1.6.x)
```
vagrant plugin install vagrant-berkshelf --plugin-version 2.0.1
```

##### vagrant plugin (vagrant 1.7.2)
```
vagrant plugin install vagrant-berkshelf --plugin-version 4.0.4
```

