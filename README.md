NetCommons3開発環境
=======

このツールは、正規のNetCommons3開発環境の構築とは異なり、2016.02.28現在、当管理者が開発で使用してるVagrant環境を基に新たな開発環境を構築するツールです。

これは、非公式のやり方です。正規の開発環境構築は[こちら](https://github.com/NetCommons3/NetCommons3/blob/master/README.md)を参照してください。

## NetCommonsとは
国立情報学研究所が次世代情報共有基盤システムとして開発しています。サポート情報やライセンスなどの最新の情報は公式サイトを御覧ください。
こちらのリポジトリは最新版として開発中のv3となります。安定版ではありませんのでご注意ください。現在の安定版については[こちらのレポジトリ](https://github.com/netcommons)をご覧ください。

<br>


## 動作実績

以下の組み合わせで動作することを確認しています。

| OS           | Memory | matrix | 備考 |
| ------------ | ------ | ------ | ----- |
| Windows 10   | 16GB   | virtualbox 5.0.12, vagrant 1.8.0 |  |
| Windows 10   | 16GB   | virtualbox 5.0.12, vagrant 1.8.1 |  |
| Windows 8.1 | 8GB   | VirtualBox:4.3.34, vagrant 1.7.2 |  |
| Windows 8.1 | 16GB   | VirtualBox:4.3.32, vagrant 1.6.5 |  |
| Windows 7 SP1 | 16GB   | virtualbox 4.3.20, vagrant 1.6.5 |  |
| Windows 7 | 16GB   | virtualbox 4.3.34, vagrant 1.7.4 | Vagrantfileを2GB(2048)に設定変更 |
| Mac 10.11.1   | 4GB   | virtualbox 5.0.14, vagrant 1.8.1 | Vagrantfileを2GB(2048)に設定変更。ただし、開発には適していない。 |

※Guest Additions Version: 4.2.0で動作確認しています。

OS：UbuntuでGuest Additions Version: 4.3.36は動かない？

### Box（ゲストOS）の構成
#### 1. NetCommons3-ubuntu（[nc3-ubuntu-php55-mysql55-mroonga.box](http://download.nakazii-co.jp/)）

| ライブラリ | バージョン | 備考
| ------------ | ------ | ------
| OS | Ubuntu 12.04 | Ubuntu 12.04 LTS (GNU/Linux 3.2.0-23-generic x86_64) 
| php | 5.5.23 | PHP 5.5.23-1+deb.sury.org~precise+2 (cli) (built: Mar 24 2015 11:00:01) 
| mysql | 5.5(mroonga) | mysql  Ver 14.14 Distrib 5.5.41, for debian-linux-gnu (x86_64) using readline 6.2

<br>


## インストール

### 1. アプリケーションのインストール
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
gitコマンドにパスを通す必要があります。設定方法は、下図を参考にしてください。クリックすると拡大されます。<br>
<a href="https://raw.githubusercontent.com/s-nakajima/NC3/master/img/Windows.2.PNG">
<img src="https://raw.githubusercontent.com/s-nakajima/NC3/master/img/Windows.2.PNG" width="400px">
</a>
<a href="https://raw.githubusercontent.com/s-nakajima/NC3/master/img/Windows.PNG">
<img src="https://raw.githubusercontent.com/s-nakajima/NC3/master/img/Windows.PNG" width="320px">
</a><br>

### 2. 事前準備

#### 2-1. 当プロジェクトをgit cloneして下さい。
```
git clone https://github.com/s-nakajima/NC3.git
```

#### 2-2. ゲストOSのメモリの変更（必要に応じて行う）。
デフォルト4GBに設定しています。必要に応じて、変更して下さい。ゲストOSのメモリを変更する場合は、Vagrantfileを修正して下さい。<br>
<b>【Vagrantfileの変更箇所】</b><br>
<img src="https://raw.githubusercontent.com/s-nakajima/NC3/master/img/vagrantfile.PNG">

#### 2-3. github.comのアカウントを作成してください。
https://github.com/join?source=header-home

--

### 3. インストール
#### 3-1(1). Windoswの場合
再インストールする場合、下記の4つのディレクトリを削除もしくはリネームしてください。<br>
C:\Users\（ユーザ名）\\.gem<br>
C:\Users\（ユーザ名）\\.berkshelf<br>
C:\Users\（ユーザ名）\\.vagrant.d<br>
C:\Users\（ユーザ名）\\.VirtualBox<br>

##### 3-1(1)-1. vagrant_install.batの実行
vagrant_install.batには、下記3-1(1)-2、3-1(1)-3も含め実行します。

##### 3-1(1)-2. vagrant plugin (vagrant_install.batに含まれているため、実行する必要なし)
```
vagrant plugin install vagrant-hostmanager --plugin-version 1.5.0
vagrant plugin install vagrant-omnibus --plugin-version 1.4.1
```

##### 3-1(1)-3. vagrant を起動 (vagrant_install.batに含まれているため、実行する必要なし)
配置したソースのパスで vagrant を起動します。初回のみ Box(isoファイルのようなもの) のダウンロードに時間がかかります。

```
vagrant up default
```

---

#### 3-1(2). Mac
##### 3-1(2)-1. vagrant_install.commandの実行
vagrant_install.commandには、下記3-1(2)-2、3-1(2)-3も含めインストールします。

##### 3-1(2)-2. synced_folder 有効化 (vagrant_install.commandに含まれているため、実行する必要なし)

##### 3-1(2)-3. vagrant plugin (vagrant_install.commandに含まれているため、実行する必要なし)
```
vagrant plugin install vagrant-hostmanager
vagrant plugin install vagrant-omnibus
```

##### 3-1(2)-4. vagrant を起動 (vagrant_install.commandに含まれているため、実行する必要なし)
配置したソースのパスで vagrant を起動します。初回のみ Box(isoファイルのようなもの) のダウンロードに時間がかかります。
```
vagrant up default
```

---

#### 3-1(3). それ以外（Ubuntuなど）
##### 3-1(3)-1. synced_folder 有効化
virtualbox のある時点から Windows では synced_folder 上で symlink でリンクが貼れません。
synced_folder を有効にしたままで vagrant up すると symlink が破壊されます。そのため、当Vagrantfileは、synced_folderを無効にしています。

下記の通り Vagrantfile から 『disabled: true』 を削除して下さい。

```
node.vm.synced_folder '.', '/var/www/app', disabled: true,
:create => true, :owner=> 'www-data', :group => 'www-data'
```
↓
```
node.vm.synced_folder '.', '/var/www/app',
:create => true, :owner=> 'www-data', :group => 'www-data'
```

##### 3-1(3)-2. vagrant plugin
```
vagrant plugin install vagrant-hostmanager
vagrant plugin install vagrant-omnibus
```

##### 3-1(3)-3. vagrant を起動
配置したソースのパスで vagrant を起動します。初回のみ OS のダウンロードに時間がかかります。

```
vagrant up default
```

--

### 4. setupシェルの実行
vagrant が正常に起動された後に、vagrant により作成された仮想環境（ゲスト環境）に SSH で接続し、下記コマンドを実行してください。  
SSH 接続には、Putty などの SSH クライアントソフトを使用し、127.0.0.1 のポート 2222 に接続してください。  
SSH 認証のユーザ名とパスフレーズはともに「vagrant」です。

下記のコマンドを実行し、s-nakajima/MyShellとNetCommonos3の最新化する

```
sudo -s /var/www/setup
```

--

### 5. 動作確認

| URL                      | 用途                                 |
| ------------------------ | ------------------------------------ |
| http://127.0.0.1:9090    | netcommons 本体                      |


#### ログインユーザ

| ユーザ             | ログインID   | パスワード |
| ------------------ | ------------ | ---------- |
| システム管理者     | admin        | admin      |
| 編集長             | chief_editor | admin      |
| 編集者             | editor       | admin      |
| 一般               | general_user | admin      |
| 参観者（ビジター） | visitor      | admin      |


--

### 6. 開発
Windowsの場合、Windows のホスト側にてファイルを編集する場合は、下記 samba をマウントし作業してください。

```
\\10.0.0.10\shared\app
```

その他の OS は vagrant up したディレクトリ直下のファイルを直接編集するだけで host <=> guest 間でファイルが同期できます。

--

### 7. 終了
vagrantコマンドで仮想マシンを終了します。
Windowsの場合は、vagrant-halt.batで終了することができます。

```
vagrant halt
```

--

### 8. 再開
vagrantコマンドで仮想マシンを再開します。
Windowsの場合は、vagrant-up.batで再開することができます。

```
vagrant up default
```

<br>


## その他
* 開始する場合

```
vagrant up default
```

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

<br>

## 参考
* [Vagrantでexportした環境(box)を取り込む方法]http://d.hatena.ne.jp/yohei-a/20110124/1295887695br>
<br>
* VirtualBoxの仮想ディスクの圧縮<br>
下記の手順で行う<br>
(1) 下記をコマンドプロンプトから実行する<br>
``` "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" clonehd "C:\Users\snakajima\VirtualBox VMs\NC3_default_1456842945656_45946\box-disk1.vmdk" "C:\Users\snakajima\VirtualBox VMs\NC3_default_1456842945656_45946\clone.vdi" --format vdi ```<br>
<br>
(2) 下記をコマンドプロンプトから実行する<br>
``` "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" modifyhd "C:\Users\snakajima\VirtualBox VMs\NC3_default_1456842945656_45946\clone.vdi" compact ```<br>
<br>
(3) 下記をコマンドプロンプトから実行する<br>
``` "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" clonehd "C:\Users\snakajima\VirtualBox VMs\NC3_default_1456842945656_45946\clone.vdi" "C:\Users\snakajima\VirtualBox VMs\NC3_default_1456842945656_45946\clone.vmdk" --format vmdk ```<br>
<br>
(4) VirtualBoxを起動し、ストレージを変更する<br>
<a href="https://raw.githubusercontent.com/s-nakajima/NC3/master/img/virtualbox.PNG">
<img src="https://raw.githubusercontent.com/s-nakajima/NC3/master/img/virtualbox.PNG" width="400px">
</a><br>
<br>
(参考)
 * [VirtualBoxの仮想ディスクのサイズを変更する](http://qiita.com/niwashun/items/f71b0b805a6f97b514ec)
 * [VirtualBoxの仮想ディスクの圧縮](http://vboxmania.net/content/%E4%BB%AE%E6%83%B3%E3%83%87%E3%82%A3%E3%82%B9%E3%82%AF%E3%81%AE%E5%9C%A7%E7%B8%AE)<br>
<br>
* [Vagrant docs](https://www.vagrantup.com/docs/)<br>
<br>
* [VagrantのBoxリスト](https://atlas.hashicorp.com/boxes/search)<br>
<br>
* [CentOS7にPHP5.6,MySQL5.7,Nginx1.8の環境構築](http://qiita.com/fujiiiiii/items/a1c880f058b71595d15c#php%E8%A8%AD%E5%AE%9A)<br>
<br>
<br>
* Boxファイルの作成
~~~~
# box 作成用のフォルダ(任意)に移動します。
> cd xxxx(box 作成用のフォルダ)

# box を作成します。
# --base：作成対象の仮想マシン名、--output：出力 box ファイル名
> vagrant package --base "C:\Users\snakajima\VirtualBox VMs\NC3CentOS72_default_1483201373740_49744" --output CentOS-6.7-x86_64.box
==> CentOS-6.7-x86_64: Exporting VM...
==> CentOS-6.7-x86_64: Compressing package to: C:/appli/vagrant/centos/CentOS-6.7-x86_64.box

# 作成した box ファイルを確認します。
> dir
...
YYYY/MM/DD  hh:mm       689,442,753 CentOS-6.7-x86_64.box
...
~~~~

* [VT-xの有効可](http://d.hatena.ne.jp/yohei-a/20110124/1295887695)
CLIでVT-x is not availableやVERR_VMX_NO_VMX等のエラーでVirtualBox VMが起動しない場合、BOISでVT-xを有効にする必要がある。
