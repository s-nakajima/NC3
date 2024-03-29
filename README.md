NetCommons3開発環境
=======

このツールは、正規のNetCommons3開発環境の構築とは異なり、2021.02.10現在、当管理者が開発で使用してるVagrant環境を基に新たな開発環境を構築するツールです。

## NetCommonsとは

国立情報学研究所が次世代情報共有基盤システムとして開発しています。サポート情報やライセンスなどの最新の情報は公式サイトを御覧ください。

## インストール

### 1. アプリケーションのインストール
下記アプリケーションをインストールして下さい。

* virtualbox (Windowsの場合、6.1.22にしてください。)
  * [https://www.virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads)
* vagrant
  * [http://www.vagrantup.com/downloads.html](http://www.vagrantup.com/downloads.html)<br>
Windows ホストの場合、vagrant は 管理者権限が必要なフォルダ（Program Files 等）にはインストールしないようにしてください。vagrant 起動時にエラーが発生します。

* chef-dk
  * [https://downloads.chef.io/tools/chefdk](https://downloads.chef.io/tools/chefdk)

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
Windowsの場合、ファイルがCRLFに自動的に変換されてしまうため、下記のコマンドを実行し、CRLFに変換しないように設定してからgit cloneしてください。<br>
参考）http://qiita.com/yokoh9/items/1ec8099696ade0c1f36e
````
git config --global core.autoCRLF false
````

```
git clone https://github.com/s-nakajima/NC3.git
```


#### 2-2. ゲストOSのメモリの変更（必要に応じて行う）。

※Macの場合、Vagrantfile.macをVagrantfileに変更してご利用ください。

デフォルト4GBに設定しています。必要に応じて、変更して下さい。ゲストOSのメモリを変更する場合は、Vagrantfileを修正して下さい。<br>
<b>【Vagrantfileの変更箇所】</b><br>
<img src="https://raw.githubusercontent.com/s-nakajima/NC3/master/img/vagrantfile.PNG">

#### 2-3. github.comのアカウントを作成してください。
https://github.com/join?source=header-home


#### 2-4. Vagrantfileの40行目から43行目を各自githubのアカウント情報に修正してください。

※Macの場合、Vagrantfile.macをVagrantfileに変更してご利用ください。

~~~~
39:    node.vm.provision "shell", privileged: false, inline: <<-SHELL
40:        GITNAME=""       # <---- GithubのID
41:        GITPW=""         # <-- Githubのアクセストークン(https://github.com/settings/tokens)
42:        GITMAIL=""       # <---- Githubのメールアドレス
43:        COMPOSERTOKEN="" # <---- Githubのアクセストークン(https://github.com/settings/tokens)
44:
45:        if [ ! "$GITNAME" = "" ] ; then
~~~~


---


### 3. インストール
#### 3-1(1). Windoswの場合
再構築する場合、下記の4つのディレクトリを削除もしくはリネームしてください。<br>
C:\Users\（ユーザ名）\\.gem<br>
C:\Users\（ユーザ名）\\.berkshelf<br>
C:\Users\（ユーザ名）\\.vagrant.d<br>
C:\Users\（ユーザ名）\\.VirtualBox<br>

##### 3-1(1)-1. vagrant-install.batの実行
`vagrant-install.bat`は、下記3-1(1)-2、3-1(1)-3も含め実行します。

配置したソースのパスで vagrant を起動します。初回のみ Box(isoファイルのようなもの) のダウンロードに時間がかかります。

もしvagrant up時にエラーが発生し、うまくインストールができなかった場合、`vagrant halt`を実行してVagrantを停止したのち、まずは実行ログを確認してください。実行ログは、logsディレクトリに出力されています。実行ログを確認して、下記のエラーであれば、記載している対処方法を試したのち、`vagrant-up.bat` もしくは `vagrant up`を実行してください。


- `vagrant up`時に下記のエラーの場合、場合、https://qiita.com/d2cdot-mmori/items/1c340f175ae510e4456a を参考に公開鍵をセットしてください。

````
(省略)
default: SSH username: vagrant
default: SSH auth method: private key
default: Warning: Remote connection disconnect. Retrying...
default: Warning: Authentication failure. Retrying...
default: Warning: Authentication failure. Retrying...
default: Warning: Authentication failure. Retrying...
(省略)
default: Warning: Authentication failure. Retrying...
default: Warning: Authentication failure. Retrying...
Timed out while waiting for the machine to boot. This means that
Vagrant was unable to communicate with the guest machine within
the configured ("config.vm.boot_timeout" value) time period.

If you look above, you should be able to see the error(s) that
Vagrant had when attempting to connect to the machine. These errors
are usually good hints as to what may be wrong.

If you're using a custom box, make sure that networking is properly
working and you're able to connect to the machine. It is a common
problem that networking isn't setup properly in these boxes.
Verify that authentication configurations are also setup properly,
as well.

If the box appears to be booting properly, you may want to increase
the timeout ("config.vm.boot_timeout") value.
````

- `vagrant up`時に、CLIでVT-x is not availableやVERR_VMX_NO_VMXでエラーが出る場合があります。その場合は、VT-xを有効にしてください。
有効にする方法は、[VT-xの有効可](http://d.hatena.ne.jp/yohei-a/20110124/1295887695)を参考にしてください。

- 下記のエラーが発生した場合、VirtualBox Guest Additionsのバージョンの相違していることでエラーが発生しています。
その場合、`vagran reload`を実行してください。
````
Vagrant was unable to mount VirtualBox shared folders. This is usually
because the filesystem "vboxsf" is not available. This filesystem is
made available via the VirtualBox Guest Additions and kernel module.
Please verify that these guest additions are properly installed in the
guest. This is not a bug in Vagrant and is usually caused by a faulty
Vagrant box. For context, the command attempted was:

mount -t vboxsf -o uid=1000,gid=1000,_netdev vagrant /vagrant

The error output from the command was:

: Invalid argument
````

- 下記のエラーが発生した場合、セキュリティソフトが妨げになっています。セキュリティソフトを一時停止してください。一度環境構築が成功した後は、セキュリティソフトを停止する必要はありません。


````
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Box 'nc3-centos71-php72' could not be found. Attempting to find and install...
    default: Box Provider: virtualbox
    default: Box Version: >= 0
There was an error while downloading the metadata for this box.
The error message is shown below:

schannel: next InitializeSecurityContext failed: Unknown error (0x80092012) - 失効の関数は証明書の失効を確認できませんでした。
````
````
(省略)
An error occurred while downloading the remote file. The error
message, if any, is reproduced below. Please fix this error and try
again.

schannel: next InitializeSecurityContext failed: Unknown error (0x80092012) - 失効の関数は証明書の失効を確認できませんでした。
````


- 下記のエラーが発生した場合、原因が特定できていません。VirtualBoxのバージョンをダウングレードした後、試してください。

````
(省略)
    default: 8983 (guest) => 8983 (host) (adapter 1)
==> default: Running 'pre-boot' VM customizations...
==> default: Booting VM...
There was an error while executing `VBoxManage`, a CLI used by Vagrant
for controlling VirtualBox. The command and stderr is shown below.

Command: ["startvm", "ca8dffb7-a74f-42af-9242-1f883d0c7c5c", "--type", "headless"]

Stderr: VBoxManage.exe: error: The VM session was closed before any attempt to power it on

VBoxManage.exe: error: Details: code E_FAIL (0x80004005), component SessionMachine, interface ISession
````


##### 3-1(1)-2. vagrant plugin (vagrant_install.batに含まれているため、実行する必要なし)
```
vagrant plugin install vagrant-hostmanager
vagrant plugin install vagrant-omnibus
vagrant plugin install vagrant-vbguest
```

##### 3-1(1)-3. vagrant を起動 (vagrant_install.batに含まれているため、実行する必要なし)
配置したソースのパスで vagrant を起動します。初回のみ Box(isoファイルのようなもの) のダウンロードに時間がかかります。

```
vagrant up default
```


----

#### 3-1(2). Mac
##### 3-1(2)-1. vagrant-install.commandの実行
vagrant-install.commandには、下記3-1(2)-2、3-1(2)-3も含めインストールします。

##### 3-1(2)-2. synced_folder 有効化 (vagrant_install.commandに含まれているため、実行する必要なし)

##### 3-1(2)-3. vagrant plugin (vagrant_install.commandに含まれているため、実行する必要なし)
```
vagrant plugin install vagrant-hostmanager
vagrant plugin install vagrant-omnibus
vagrant plugin install vagrant-vbguest
```

##### 3-1(2)-4. vagrant を起動 (vagrant_install.commandに含まれているため、実行する必要なし)
配置したソースのパスで vagrant を起動します。初回のみ Box(isoファイルのようなもの) のダウンロードに時間がかかります。
```
vagrant up default
```

----

#### 3-1(3). それ以外（Ubuntuなど）
##### 3-1(3)-1. synced_folder 有効化
virtualbox のある時点から Windows では synced_folder 上で symlink でリンクが貼れません。
synced_folder を有効にしたままで vagrant up すると symlink が破壊されます。そのため、当Vagrantfileは、synced_folderを無効にしています。

下記の通り Vagrantfile から 『disabled: true』 を削除して下さい。

```
node.vm.synced_folder '.', '/var/www/app', disabled: true,
:create => true, :owner=> 'vagrant', :group => 'vagrant'
```
↓
```
node.vm.synced_folder '.', '/var/www/app',
:create => true, :owner=> 'vagrant', :group => 'vagrant'
```

##### 3-1(3)-2. vagrant plugin
```
vagrant plugin install vagrant-hostmanager
vagrant plugin install vagrant-omnibus
vagrant plugin install vagrant-vbguest
```

##### 3-1(3)-3. vagrant を起動
配置したソースのパスで vagrant を起動します。初回のみ OS のダウンロードに時間がかかります。

```
vagrant up default
```

----

### 4. setupシェルの実行
vagrant が正常に起動された後に、vagrant により作成された仮想環境（ゲスト環境）に SSH で接続し、下記コマンドを実行してください。  
SSH 接続には、Putty などの SSH クライアントソフトを使用し、127.0.0.1 のポート 2224 に接続してください。  
SSH 認証のユーザ名とパスフレーズはともに「vagrant」です。

下記のコマンドを実行し、s-nakajima/MyShellとNetCommonos3の最新化する

```
[vagrant@app MyShell]$ cd /var/www/MyShell/
[vagrant@app MyShell]$ git pull

[vagrant@app install]$ cd /var/www/MyShell/install/
[vagrant@app install]$ bash install.sh
Use "sudo". Do you want to continue?
y(es)/n(o) [n]> y
```
※参考）[s-nakajima/MyShell/install](https://github.com/s-nakajima/MyShell/tree/master/install)

----

### 5. 動作確認

| URL                      | 用途                                 |
| ------------------------ | ------------------------------------ |
| http://10.0.0.14    | netcommons 本体                      |


#### ログインユーザ

| ユーザ             | ログインID   | パスワード |
| ------------------ | ------------ | ---------- |
| システム管理者     | admin        | admin      |
| 編集長             | chief_editor | admin      |
| 編集者             | editor       | admin      |
| 一般               | general_user | admin      |
| 参観者（ビジター） | visitor      | admin      |


----

### 6. 開発
Windowsの場合、Windows のホスト側にてファイルを編集する場合は、下記 samba をマウントし作業してください。

```
\\10.0.0.14\shared\app
```

その他の OS は vagrant up したディレクトリ直下のファイルを直接編集するだけで host <=> guest 間でファイルが同期できます。

----

### 7. 終了
vagrantコマンドで仮想マシンを終了します。
Windowsの場合は、vagrant-halt.batで終了することができます。

```
vagrant halt
```

----

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

* [VT-xの有効可](http://d.hatena.ne.jp/yohei-a/20110124/1295887695)<br>
CLIでVT-x is not availableやVERR_VMX_NO_VMX等のエラーでVirtualBox VMが起動しない場合、BOISでVT-xを有効にする必要がある。
