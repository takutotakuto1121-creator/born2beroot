# memo
## サーバーの仮想化
### サーバーの仮想化
物理的な1台のサーバーで複数の仮想的なサーバーを運用することを、**サーバーの仮想化**といいます。
利用する仮想化ソフトウェアによって、**ホスト型**, **ハイパーバイザー型**の２種類に分類される。ホスト型では、ホストOS上に仮想化ソフトウェアを立ち上げ、そこでゲストOSを運用する、ハイパーバイザー型では、ハイパーバイザーと呼ばれる仮想化ソフトウェアを動作させ、その上でゲストOSを運用します。

![image](assets/host_hyper.png)
画像は[引用元](https://www.kagoya.jp/howto/engineer/itsystem/virtualization/)より引用

## Linux
### Linuxカーネルとディストリビューション
**Linux**カーネルとは、OSの心臓部であり、CPU・メモリ・ストレージといったハードウェアを管理する中核プログラムです。
**ディストリビューション**とは、Linuxカーネルにテキストエディタ・パッケージ管理ツール・シェル・ログイン画面などを組み合わせて、実際に使えるOSとして完成させたものです。

### Debian系とRed Hat系
Linuxディストリビューションには大きく分けて2つの系統があります。**Debian系**と**Red Hat系**です。以下のような違いがあります。

| 系統 | 代表例 | パッケージ管理 | 主な用途 |
|---|---|---|---|
| Debian系 | Ubuntu, Debian | apt(apt-get) | デスクトップ・開発・クラウド |
| Red Hat系 | AlmaLinux, Rocky Linux, RHEL | dng(yum) | 企業向けサーバー・本番環境 |

パッケージ管理ツールが違うだけで、基本操作はどのディストリビューションもほとんど同じです。

### MACとDAC
Linuxで採用されているファイルパーミッションには、**任意アクセス制御(DAC)**と、**強制アクセス制御(MAC)**があります。DACはファイルの所有者がアクセス権限を自由に変更できるものです。MACはシステム全体で一元的にセキュリティポリシーを管理し、ユーザーやそのプロセスがそのポリシーに違反する操作を強制的に制限します。MACの代表的な仕組みには、**SELinux**と、**AppArmor**があります。

### SELinuxとAppArmor
#### SElinux
Red Hat系のLinuxディストリビューションで採用されています。

#### AppArmor
Debian系のLinuxディトリビューションで採用されています。

## VirtualBox
### VirtualBoxとは
**VirtualBox**とは、既存のOS上で別yのOSを実行するのに使う仮想環境を構築するためのオープンソフトウェアです。ホストOS型で使用される仮想化ソフトウェアの１つです。macOSでは使用できません。
### 使用方法
#### ダウンロード
まずはVirtualBoxを[公式サイト](https://www.virtualbox.org/?_fsi=smWrwEF7)からダウンロードしてきます。
#### 起動
ダウンロードをしたら、起動します。以下はUbuntuでVirtualBoxを使用したときの動作になりますが、他のOSでもほとんど同じでしょう。
以下の写真のようにホーム画面が起動できれば、Newを押してください。

![image](assets/virtualbox/virtualbox_1.png)

すると、以下のようなウィンドウが立ち上がります。ここに必要情報を入れていくことにより、仮想環境を構築できます。

![image](assets/virtualbox/virtualbox_2.png)

#### Debianのダウンロード
[公式サイト](debian.org)より、Debianのisoイメージをダウンロードしてきます。

#### 設定
VirtualBoxの指示に従って、必要情報を書き込んでいきます。
Nameには仮想環境の名前を、Folderには仮想環境を構築するフォルダーを、ISO Imageには使用するOSのisoイメージを入力してください。42のPCを使用している場合は、Folderはgoinfreあるいはsgoinfreを指定するようにしてください。homeに保存すると容量が足りなくなるためです。isoイメージには、先程ダウンロードしてきたDebianのiosイメージのパスを入力します。

*Skip Unattended Installation*にはチェックを入れておきましょう。オートインストールをしてしまうと、 GUIつきのDebianになってしまいます。

![image](assets/virtualbox/virtualbox_3.png)

次に、RAMとCPUの割り当てを行います。RAMのメモリは今回は2048MBあれば十分です。CPUも１で構いません。

![image](assets/virtualbox/virtualbox_4.png)

次に、ハードディスクの割り当てを行います。40GBあれば十分です。

![image](assets/virtualbox/virtualbox_5.png)

最後に確認画面が表示されます。不備があればBackで設定し直しましょう。大丈夫な場合はFinishで完了します。

![image](assets/virtualbox/virtualbox_6.png)

設定したdebianがホーム画面の左側に表示されます。選択してStartを押して起動します。

![image](assets/virtualbox/virtualbox_7.png)

## UTM
### UTMとは
Virtualboxと同じく、ホストOS型の仮想環境を構築するソフトウェアです。macOSで使用できるのが特徴です。

### Debianのインストール
[公式サイト]()Debianをインストールしてきます。netinst CD イメージ (約 150-300 MB ですがアーキテクチャよって変わります)の、arm64のisoイメージをインストールします。

### 使用方法
まずは[公式サイト](https://mac.getutm.app)からUTMをダウンロードしてきてください。

次に、UTMを起動してください。起動すると以下のような画面が表示されます。新規仮想マシンを作成を選択します。

![image](assets/UTM/1.png)

仮想化かエミュレートかの選択肢が表示されます。仮想化はMacのCPUをそのまま使用します。エミュレートはソフトウェアで別のCPUを擬似的に再現します。エミュレートでもいいですが、より高速な仮想化を選択します。

![image](assets/UTM/2.png)

OSを選択します。DebianはLinuxなのでLinuxを選択します。

![image](assets/UTM/3.png)

ハードウェアのメモリ容量とCPUコア数を指定します。課題をするだけなら、メモリは2048Mib, CPUコア数は1で十分です。
*Enable display output*にはチェックを入れておきましょう。チェックを入れないと画面表示が正確にされません。ハードウェアOpenGLアクセラレーションは推奨の通り有効にはしないでおきます。

![image](assets/UTM/4.png)

Apple仮想化は推奨の通り使用しません。起動イメージの種類は*Boot from ISO image*を選択します。起動ISOイメージには、ダウンロードしたarm64のDebianのISOイメージのパスを指定します。

![image](assets/UTM/5.png)

ストレージ容量を指定します。課題では40GiBあれば十分です。

![image](assets/UTM/6.png)

ホストOSとの共有ディレクトリを指定します。何も指定しなくていいです。したければ指定してください。

![image](assets/UTM/7.png)

確認画面です。問題なケラば保存を押してください。間違いがあれば戻るで修正してください。

![image](assets/UTM/8.png)

完成したら、起動してください。再生ボタンを押して起動します。

![iamge](assets/UTM/9.png)

## Debian
### Debian
**Debian**とは、Linuxディストリビューションの１つで、圧倒的な安定性と信頼性から、多くのサーバーで採用されています。
### インストール
Debianを初めて起動すると、まず以下のような画面が表示されます。Installを選択しましょう。Graphical installを選択してしまうと、GUI月になってしまうので気をつけてください。

![image](assets/debian/debian_1.png)

次に言語を選択します。好きな言語を選択してください。今回はJapaneseを選択します。Englishでもいいです。

![image](assets/debian/debian_2.png)

場所を選択します。言語でJapaneseを選択したので、アジアの一覧が表示されました。日本を選択します。

![image](assets/debian/debian_3.png)

キーマップを選択します。JIS配列のキーボードの場合は日本語を、US配列のキーボードの場合は米国を選択してください。今回は米国を選択します。

![image](assets/debian/debian_4.png)

ネットワークの設定を行います。ホスト名を入力します。`intra名`42にしてください。私の場合はtsugimot42です。


![image](assets/debian/debian_5.png)

ドメイン名を設定します。空白で構いません。設定したければ好きな名前を設定してください。

![image](assets/debian/debian_6.png)

rootのパスワードを設定します。これは強いパスワードポリシーの元で設定される必要があります。ただ、後で変更するので今は仮のパスワードになります。パスワードを表示/非表示にするにはパスワードに表示の部分でスペースを押してください。

![image](assets/debian/debian_7.png)

確認のため、パスワードを再度入力します。

![image](assets/debian/debian_8.png)

ユーザを追加します。本名を入れる欄ですが、本名でも自分のintra名でも何でも構いません。

![image](assets/debian/debian_9.png)

追加したユーザのユーザ名を指定します。自分のintra名にして下さい。

![image](assets/debian/debian_10.png)

同様に追加したユーザのパスワードを設定します。強いパスワードポリシーの元で設定される必要があります。これも後で変更します。

暗号化LVMをセットアップします。ガイド - ディスク全体を使い、暗号化LVMをセットアップする。ボーナスを刷る場合は異なりますが、今回はMandatoryの実装に留めておきます。

![image](assets/debian/debian_11.png)

確認画面です。エンターを押して下さい。

![image](assets/debian/debian_12.png)

LVMを用いて、少なくとも２つのパーティションに分割します。少なくとも２つに分割できていればどれでもいいです。今回は、 /home, /var, /tmpに分割します。

![image](assets/debian/debian_13.png)

確認画面です。はいを押して下さい。

![image](assets/debian/debian_14.png)

これは待ってもいいですが、今回は関係ないのでキャンセルしても構いません。

![image](assets/debian/debian_16.png)

パスワードを設定します。

![image](assets/debian/debian_15.png)

パーティションに用いるサイズを指定します。デフォルト値のままでもなんでもいいです。

![image](assets/debian/debian_17.png)

確認画面です。問題なければパーティショニングを終了して、ディスクへ変更内容を書き込みましょう。

![image](assets/debian/debian_18.png)

また変更です。はいを押して下さい。

![image](assets/debian/debian_19.png)

しなくていいのでいいえを押して下さい。

![image](assets/debian/debian_20.png)

自分の国を選択して下さい。日本を選択します。

![image](assets/debian/debian_21.png)

推奨の通り、deb.debian.orgを選択します。

![image](assets/debian/debian_22.png)

今回の課題ではHTTPプロキシは使用しないので、空白のママ続けてください。使いたければ指定してもいいです。

![image](assets/debian/debian_23.png)

どちらを選択しても構いません。好きな方を選びましょう。

![image](assets/debian/debian_24.png)

定義済みのソフトウェアをインストールできます。課題は最小限なのでインストールしなくて構いません。したければして下さい。

![image](assets/debian/debian_25.png)

GNU GRUBをインストールします。はいを押してください。

![image](assets/debian/debian_26.png)

インストール先を選択します。/dev/sdaにします。

![image](assets/debian/debian_27.png)

インストールが完了しました。続けるを押してください。

![image](assets/debian/debian_28.png)

以上でインストール完了です！

UTMを使用している場合、一度電源を落とした後に以下のCD/DVDを削除してください。

![image](assets/UTM/10.png)

右上の設定マークを押し、ディスプレイの仮想ディスプレイカードをvirtio-ramfbに変更してください

設定マークを押し、デバイスの新規からシリアルを追加してください。

![image](assets/UTM/11.png)

以上の設定をこなうと、以下のようにウィンドウが２つ開き、UTMでも使用できるようになります！

### 起動
Debianを起動すると、
```bash
Please unlock disk sda5_crypt:
```
と表示されます。暗号化LVMのパスワードを入力してロックを解除してください。
解除できない問題が発生した場合は、コピペで文字を入力してみてください。

次にユーザ名とパスワードが求められるので、入力してロックを解除してください。

以上で起動完了です！

### sudo
#### sudo
**sudo**コマンドとは、あるユーザが他のユーザ、他のグループの権限を用いて、プログラムなどを実行出来るようにするコマンドです。
よくある使われ方としては、一般ユーザにroot権限を一時的に付与してプログラムを実行させるというものです。
以下のように使用する。
ユーザ名を指定しなければrootが指定される。
```bash
sudo -u [ユーザ名] [実行したいコマンド]
```

初期状態ではDebianにsudoコマンドはインストールされていないので、**su**コマンドで直接rootユーザに切り替えて、インストールしてあげる必要があります。
```bash
su
apt install sudo
```

#### su
**su**コマンドは、ユーザーを変更するコマンドです。以下のように使用します。ユーザ名を指定しなければrootが指定されます。
```bash
su [ユーザ名]
```

元に戻るには、以下のように**exit**コマンドを使用します。
```bash
exit
```

今どのユーザなのかを確認するには以下のコマンドを使用します。
```bash
echo $USER
whoami
id
```

#### /etc/sudoers
**/etc/sudoers**は、sudoコマンドで変更できるユーザと実行出来るコマンドを記述する設定ファイルです。
`/etc/sudoers`は、設定を1文字でも間違えると二度とsudoが使えなくなり、システムを壊してしまう可能性のある非常に危険なファイルです。そのため、直接`vi /etc/sudoers`で編集することは推奨されません。
以下の専用コマンドを使用してください。
```bash
sudo visudo
```
このコマンドを使用すると、保存して終了する前に、設定内容に間違いがないかをシステムが自動で確認し、エラーがあれば保存を止めてくれます。

`/etc/sudoers`に記述するルールを解説します。
基本ルールは、誰が、どこで、誰の権限で、何を実行出来るかを左から順番に記述する方式になっています。ALLにすると、全てを指します。
```bash
ユーザ名 ホスト名=(権限元のユーザ:権限元のグループ) 実行出来るコマンド
```
例えば以下のように指定します。
```bash
tsugimot tsugimot42=(ALL) /usr/bin/ls
tsugimot ALL=(ALL:ALL) ALL
```
開発環境などで、いちいちパスワードを打つのが面倒な場合は、以下を指定すると不要になります。セキュリティが下がるので注意が必要です。
```bash
tsugimot ALL=(ALL:ALL) NOPASSWD: ALL
```

### nano
テキストエディタの１つ。大体のLinuxには標準でインストールされている
```bash
nano [ファイル名]
```
でエディタが開く。そのまま書き込んで、`Ctrl + O`で書き込む。
ファイルに書き込みに書き込むファイルを指定する。
~行を書き込みましたという表示が出てきたら書き込み完了。
`Ctrl + X`で終了する。

### aptとaptitude
#### apt
**apt**は、Debian系のディストリビューションで標準的に使われるパッケージ管理ツールです。
シンプルで直感的、デフォルトでインストールされている、表示がわかりやすいなどのメリットがあります。
一方で、依存関係の処理が苦手だというデメリットもあります。
よく使うコマンドは以下です。
```bash
sudo apt update             # パッケージ情報の更新
sudo apt install [target]   # targetのインストール
sudo apt upgrade            # インストール済みパッケージの更新
```

#### aptitude
**aptitude**は、基本的にはaptと同じですが、複雑な依存関係の衝突を自動的に検知し、複数の解決策を提示してくれます。これにより、安全にパッケージのアップグレードなどを行えます。
インストールは以下のようにaptでインストールします。
```bash
sudo apt install aptitude
```

#### aptとaptitudeの違い
aptは簡単で使いやすいです。aptitudeは高度な依存関係の処理も行えますが、操作ミスによる影響が多いので、上級者向けの選択肢です。

## SSH
### SSH
**SSH**とは、Secure Shellの略で、ネットワークを経由して別のコンピュータを操作する際に使用するプロトコルのことです。

sshdとufw両方

### OpenSSH
SSHプロトコルを行うためのオープンソースソフトウェアのこと。以下のコマンドでインストールします。
```bash
sudo apt install openssh-server
```

sshのステータスは以下のコマンドで確認できます。
```bash
sudo  systemctl status ssh
```

`enabled`の表示が出ていれば「今」SSHサーバーが起動しています。
`active(running)`の表示が出ていれば、「OS起動時」にサービスを自動で立ち上げます。

それぞれ以下のコマンドでenabled/disabled, active/inactiveを切り替えれます。

```bash
sudo systemctl start ssh
sudo systemctl stop ssh
sudo systemctl restart ssh # activeのまま再起動
sudo systemctl enable ssh
sudo systemctl disable ssh
```

### ufw
**ufw**は、Debian系Linuxで標準的に使用されるファイアウォール管理ツールです。

```bash
sudo apt install ufw
```

でインストールします。

```bash
sudo ufw status
```

でステータスを確認します。
基本的な設定例は以下のとおりです。

```bash
# 外部からの接続をすべて拒否
sudo ufw default deny incoming
# 内部からの通信はすべて許可
sudo ufw default allow outgoing
# 特定のポートの通信を許可
sudo ufw allow [ポート]
# 特定のポートからの通信を拒否
sudo ufw deny [ポート]
# 許可ルールを削除
sudo ufw delete allow [ポート]
# 拒否ルールを削除
sudo ufw delete deny [ポート]
# 特定のIPからの許可
sudo ufw allow from [IPアドレス] to any port [ポート] proto tcp
# 状態確認
sudo ufw status verbose
```
`sudo ufw allow 4242`で、4242のポートの見通し用にしてください。

### /etc/ssh/sshd_config
`/etc/ssh/sshd_config`は、ssh関連の設定を刷るファイルです。なんでもいいですが、nanoで編集するなら以下のようにします。

```bash
sudo nano /etc/ssh/sshd_config
```

**# Port 22**の部分のコメントを外し、**Port 4242**にすることにより、4242のポートの接続を許可します。SSH接続を最低限するにはここの設定のみで大丈夫です。 設定をしたければ他にも色々設定できます。

以下のコマンドでsshd_configの設定を反映させます。
```bash
sudo systemctl restart sshd
```
#### systemctl
debianでは、初期システムであるsystemdを操作するために、systemctlコマンドを使用します。基本的なコマンドは以下です。
```bash
sudo systemctl start [サービス名]
sudo systemctl stop [サービス名]
sudo systemctl restart [サービス名]
sudo systemctl status [サービス名]
# Linuxの起動時に指定したサービスを自動的に起動するためのコマンド
sudo systemctl enable [サービス名]
sudo systemctl disable [サービス名]
sudo systemctl status [サービス名]
```

### VirtualBoxの設定
一度debianの電源を落として、VirtualBoxホーム画面でSettingを開いてください。SettingでNetworkを選択してください。すると、以下のような画面が表示されます。

![image](assets/virtualbox/8.png)

Advancedを押してください。以下のような画面になるので、Port Forwardingを押してください。

![image](assets/virtualbox/9.png)

最後に、右上のプラスマークを押して、新規のルールを追加します。Guest Portは課題の要件通り4242にしてください。Host Portは何でも構いません。

![image](assets/virtualbox/10.png)

### ホストOSからのSSH接続
openSSHの設定、ufwの設定、/etc/ssh/sshd_configの設定、VirtualBoxの設定がすべて完了すると、ホストOSのターミナルからSSH接続でDebianを操作できるようになります。Debianを起動している状態で、ホストOSで以下のコマンドを実行してください

```bash
ssh [ゲストOSのユーザ名]@[ゲストOSのIPアドレス] -p [ホストポート]

ssh [ゲストOSのユーザ名]@localhost -p [ホストポート]
```

ipアドレスは以下のコマンドで確認できます。
```bash
ip a
```









## ユーザとグループ
### ユーザの種類
ユーザには、一般ユーザ、rootユーザ、システムユーザが存在する。
一般ユーザは一般的なユーザです。
rootユーザはスーパーユーザともよばれ、すべての権限を持っているシステム管理者向けのユーザです。
システムユーザは、アプリケーションや常時かどうするサービス用に作成されるユーザです。

### ユーザの管理コマンド
ユーザを管理するコマンドは以下のとおりです。
```bash
id          # uid(ユーザID), ユーザ名, gid(グループID), groups(サブグループ名)
adduser     # ユーザの作成(/home/配下にディレクトリを作成)
useradd     # ユーザの作成(/home/配下にディレクトリを作成しない)
usermod     # ユーザの設定変更
userdel     # ユーザの削除
passwd      # ユーザのパスワード設定変更
```

ユーザ一覧を表示させたい場合は以下のコマンドを実行します。
```bash
cat /etc/passwd
```

### グループの種類
Linuxはマルチユーザ対応OSであり、複数の人が同時に接続して使用することが可能です。そのため、誰でも自由にファイルやディレクトリが使われることがないように、アクセス制御を設定できます。

グループは、**メイングループ**と**サブグループ**に分類されます。

メイングループは、ユーザ１人に対して必ず１つ割り当てられます。基本的にユーザ名と同じ名前のグループになります。

サブグループは、メイングループに追加で所属させるグループを設定できます。

グループを確認したい場合は以下のコマンドを実行します。

```bash
cat /etc/group
groups [ユーザ名]
```

### グループの管理コマンド
グループを管理刷るコマンドは以下のとおりです。
```bash
groupadd [グループ名]              # グループの作成
usermod -g [グループ名] [ユーザ名]  # メイングループの追加
usermod -aG [グループ名] [ユーザ名] # サブグループの追加
useradd -G [グループ名] [ユーザ名] # サブグループの変更
groupdel [グループ名] # グループの削除
getent group [グループ名] # ユーザが所属するグループの表示
gpassed -a
```
