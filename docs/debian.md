# Debian
## Debianとは
**Debian**とは、Linuxディストリビューションの１つで、圧倒的な安定性と信頼性から、多くのサーバーで採用されています。

## インストール
macOS以外の場合は[VirtualBox](virtualbox.md), macOSの場合は[UTM](UTM.md)からDebianを起動します。

Debianを初めて起動すると、まず以下のような画面が表示されます。Installを選択しましょう。Graphical installを選択してしまうと、GUI月になってしまうので気をつけてください。

![image](../assets/debian/debian_1.png)

次に言語を選択します。好きな言語を選択してください。今回はJapaneseを選択します。Englishでもいいです。

![image](../assets/debian/debian_2.png)

場所を選択します。言語でJapaneseを選択したので、アジアの一覧が表示されました。日本を選択します。

![image](../assets/debian/debian_3.png)

キーマップを選択します。JIS配列のキーボードの場合は日本語を、US配列のキーボードの場合は米国を選択してください。今回は米国を選択します。

![image](../assets/debian/debian_4.png)

ネットワークの設定を行います。ホスト名を入力します。`intra名`42にしてください。私の場合はtsugimot42です。


![image](../assets/debian/debian_5.png)

ドメイン名を設定します。空白で構いません。設定したければ好きな名前を設定してください。

![image](../assets/debian/debian_6.png)

rootのパスワードを設定します。これは強いパスワードポリシーの元で設定される必要があります。ただ、後で変更するので今は仮のパスワードになります。パスワードを表示/非表示にするにはパスワードに表示の部分でスペースを押してください。

![image](../assets/debian/debian_7.png)

確認のため、パスワードを再度入力します。

![image](../assets/debian/debian_8.png)

ユーザを追加します。本名を入れる欄ですが、本名でも自分のintra名でも何でも構いません。

![image](../assets/debian/debian_9.png)

追加したユーザのユーザ名を指定します。自分のintra名にして下さい。

![image](../assets/debian/debian_10.png)

同様に追加したユーザのパスワードを設定します。強いパスワードポリシーの元で設定される必要があります。これも後で変更します。

暗号化LVMをセットアップします。ガイド - ディスク全体を使い、暗号化LVMをセットアップする。ボーナスを刷る場合は異なりますが、今回はMandatoryの実装に留めておきます。

![image](../assets/debian/debian_11.png)

確認画面です。エンターを押して下さい。

![image](../assets/debian/debian_12.png)

LVMを用いて、少なくとも２つのパーティションに分割します。少なくとも２つに分割できていればどれでもいいです。今回は、 /home, /var, /tmpに分割します。

![image](../assets/debian/debian_13.png)

確認画面です。はいを押して下さい。

![image](../assets/debian/debian_14.png)

これは待ってもいいですが、今回は関係ないのでキャンセルしても構いません。

![image](../assets/debian/debian_16.png)

パスワードを設定します。

![image](../assets/debian/debian_15.png)

パーティションに用いるサイズを指定します。デフォルト値のままでもなんでもいいです。

![image](../assets/debian/debian_17.png)

確認画面です。問題なければパーティショニングを終了して、ディスクへ変更内容を書き込みましょう。

![image](../assets/debian/debian_18.png)

また変更です。はいを押して下さい。

![image](../assets/debian/debian_19.png)

しなくていいのでいいえを押して下さい。

![image](../assets/debian/debian_20.png)

自分の国を選択して下さい。日本を選択します。

![image](../assets/debian/debian_21.png)

推奨の通り、deb.debian.orgを選択します。

![image](../assets/debian/debian_22.png)

今回の課題ではHTTPプロキシは使用しないので、空白のママ続けてください。使いたければ指定してもいいです。

![image](../assets/debian/debian_23.png)

どちらを選択しても構いません。好きな方を選びましょう。

![image](../assets/debian/debian_24.png)

定義済みのソフトウェアをインストールできます。課題は最小限なのでインストールしなくて構いません。したければして下さい。

![image](../assets/debian/debian_25.png)

GNU GRUBをインストールします。はいを押してください。

![image](../assets/debian/debian_26.png)

インストール先を選択します。/dev/sdaにします。

![image](../assets/debian/debian_27.png)

インストールが完了しました。続けるを押してください。

![image](../assets/debian/debian_28.png)

以上でインストール完了です！

UTMを使用している場合、一度電源を落とした後に以下のCD/DVDを削除してください。

![image](../assets/UTM/10.png)

右上の設定マークを押し、ディスプレイの仮想ディスプレイカードをvirtio-ramfbに変更してください

設定マークを押し、デバイスの新規からシリアルを追加してください。

![image](../assets/UTM/11.png)

以上の設定をこなうと、以下のようにウィンドウが２つ開き、UTMでも使用できるようになります！

## 起動
Debianを起動すると、
```bash
Please unlock disk sda5_crypt:
```
と表示されます。暗号化LVMのパスワードを入力してロックを解除してください。
解除できない問題が発生した場合は、コピペで文字を入力してみてください。

次にユーザ名とパスワードが求められるので、入力してロックを解除してください。

以上で起動完了です！