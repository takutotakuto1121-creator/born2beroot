# memo
## サーバーの仮想化
### サーバーの仮想化
物理的な1台のサーバーで複数の仮想的なサーバーを運用することを、**サーバーの仮想化**といいます。
利用する仮想化ソフトウェアによって、**ホスト型**, **ハイパーバイザー型**の２種類に分類される。ホスト型では、ホストOS上に仮想化ソフトウェアを立ち上げ、そこでゲストOSを運用する、ハイパーバイザー型では、ハイパーバイザーと呼ばれる仮想化ソフトウェアを動作させ、その上でゲストOSを運用します。

![image](assets/host_hyper.png)
画像は[引用元](https://www.kagoya.jp/howto/engineer/itsystem/virtualization/)より引用

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

### suコマンド
su(switching user)コマンドでユーザーを切り替えれます。

