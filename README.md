NetCommons3開発環境
=======

このツールは、正規のNetCommons3開発環境の構築とは異なり、2021.02.10現在、当管理者が開発で使用してるVagrant環境を基に新たな開発環境を構築するツールです。

## NetCommonsとは

国立情報学研究所が次世代情報共有基盤システムとして開発しています。サポート情報やライセンスなどの最新の情報は公式サイトを御覧ください。

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
Windowsの場合、ファイルがCRLFに自動的に変換されてしまうため、下記のコマンドを実行し、CRLFに変換しないように設定してからgit cloneしてください。<br>
参考）http://qiita.com/yokoh9/items/1ec8099696ade0c1f36e
````
git config --global core.autoCRLF false
````

```
git clone https://github.com/s-nakajima/NC3.git
```


#### 2-2. ゲストOSのメモリの変更（必要に応じて行う）。
デフォルト4GBに設定しています。必要に応じて、変更して下さい。ゲストOSのメモリを変更する場合は、Vagrantfileを修正して下さい。<br>
<b>【Vagrantfileの変更箇所】</b><br>
<img src="https://raw.githubusercontent.com/s-nakajima/NC3/master/img/vagrantfile.PNG">

#### 2-3. github.comのアカウントを作成してください。
https://github.com/join?source=header-home


#### 2-4. Vagrantfileの40行目から43行目を各自githubのアカウント情報に修正してください。

~~~~
39:    node.vm.provision "shell", privileged: false, inline: <<-SHELL
40:        GITNAME=""       # <---- GithubのID
41:        GITPW=""         # <---- Githubのパスワード
42:        GITMAIL=""       # <---- Githubのメールアドレス
43:        COMPOSERTOKEN="" # <---- Githubのアクセストークン(https://github.com/settings/tokens)
44:
45:        if [ ! "$GITNAME" = "" ] ; then
~~~~


---


### 3. インストール
#### 3-1(1). Windoswの場合
再インストールする場合、下記の4つのディレクトリを削除もしくはリネームしてください。<br>
C:\Users\（ユーザ名）\\.gem<br>
C:\Users\（ユーザ名）\\.berkshelf<br>
C:\Users\（ユーザ名）\\.vagrant.d<br>
C:\Users\（ユーザ名）\\.VirtualBox<br>

##### 3-1(1)-1. vagrant_install.batの実行
vagrant_install.batには、下記3-1(1)-2、3-1(1)-3も含め実行します。

配置したソースのパスで vagrant を起動します。初回のみ Box(isoファイルのようなもの) のダウンロードに時間がかかります。

※もしvagrant up時に下記のエラーが発生し、うまくインストールができなかった場合、vagrant haltを実行してVagrantを停止したのち、3-1(4)の手順で環境構築を行う。実行ログは、logsディレクトリに出力されています。
また、下記のエラー以外に、CLIでVT-x is not availableやVERR_VMX_NO_VMXでエラーが出る場合があります。その場合は、VT-xを有効にしてください。
有効にする方法は、[VT-xの有効可](http://d.hatena.ne.jp/yohei-a/20110124/1295887695)を参考にしてください。

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

--

### 5. 動作確認

| URL                      | 用途                                 |
| ------------------------ | ------------------------------------ |
| http://127.0.0.1:9094    | netcommons 本体                      |


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
\\10.0.0.14\shared\app
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

* [VT-xの有効可](http://d.hatena.ne.jp/yohei-a/20110124/1295887695)<br>
CLIでVT-x is not availableやVERR_VMX_NO_VMX等のエラーでVirtualBox VMが起動しない場合、BOISでVT-xを有効にする必要がある。
