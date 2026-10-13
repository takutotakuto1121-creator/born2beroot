# signature.txt
## signature.txt
`signature.txt`とは、仮想マシン(VM)のディスクファイルの中身をハッシュ化(暗号化)したものです。
課題提出後にVMを起動して、ハッシュ値が一致していれば完全に同じ設定のVMであることが証明できます。

## 作成手順(VirtualBoxの場合)

## 作成手順(UTMの場合)
まずは起動したままだと、ファイルの中身が変動し続けるため、UTM上でVMを完全にシャットダウンします。

デフォルト設定の場合、VMのデータは以下のディレクトリに保存されています。

```bash
cd ~/Library/Containers/com.utmapp.UTM/Data/Documents/
```

`shasum`コマンドで実行します。

```bash
shasum [VM名].utm/Images/[何かしらの文字列].qcow2
```

出力結果を`signature.txt`に保存します。
コマンドを実行すると、以下のような英数字の文字列が出力されます。

```
9ff243b935c80f87f9a1191dc615e6b3faac4505  B1842230-E91A-4269-B366-701DCEB0AA36.qcow2
```

この
```
9ff243b935c80f87f9a1191dc615e6b3faac4505
```
の部分のみをコピーして、`signature.txt`に貼り付けます。

レビュー時に同じことを実行して、ハッシュ値g同じことが確認できれば、レビューを開始できます。