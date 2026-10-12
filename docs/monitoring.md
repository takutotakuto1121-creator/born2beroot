# monitoring.sh
## OSのアーキテクチャとカーネルのバージョンの確認
以下のコマンドで確認可能です。`monitoring.sh`では、`uname -a`を使用しています。

```bash
cat /proc/version
uname -a
```

## 物理CPU(physical CPU)数と仮想CPU(Virtual CPU)数の確認
以下のコマンドで確認可能です。

```bash
cat /proc/cpuinfo   # processorが仮想CPUの数、physical isが物理CPUの数
lscpu   # CPU(s)が仮想CPUの数、Socket(s)が物理CPUの数
nproc   # 仮想CPUの総数のみ
```

## RAMの使用状況の確認
`free`コマンドと`top`コマンドで確認可能です。`monitoring.sh`では`free`コマンドを使用しています。

### free
`free`コマンドの主なオプションは以下の通りです。

| オプション | 説明 |
|---|---|
| -b | メモリ容量をバイト単位で表示 |
| -k | メモリ容量をキロバイト単位で表示 |
| -m | メモリ容量をメガバイト単位で表示 |
| -g | メモリ容量をギガバイト単位で表示 |
| -r | メモリとスワップ領域の合計を表示 |

`free`コマンドを使用した時のそれぞれの項目は以下のようになります。

| 項目 | 説明 |
|---|---|
| total | メインメモリのサイズ |
| used | メモリ使用量 |
| free | メモリの空き容量 |
| shared | 共有メモリ |
| buffer | バッファのキャッシュ |
| cached | ページのキャッシュ |

よって、totalとusedを参照すれば、`monitoring.sh`で活用できます。

### top
%cpuがCPU使用率、%MEMがメモリ使用率です。

## ストレージの使用状況の確認
`df`コマンド, `lsblk`コマンドで確認できます。

`df`コマンドは、`df -h`としてオプションをつけることにより、人間が読みやすい形式で出力されます。

マウントポイントが/(root)の場所を見れば全体のサイズが見れますが、LVMでパーティション分割をしている場合はここにあるものが全てではありません。

`--total`オプションをつけることにより最後の行に合計が出力されます。

```bash
df -h --total
```
オプションを指定しまくれば見れます。

`lsblk`コマンドは、ツリー構造でストレージの使用状況が出力されます。

オプションをつけることにより、項目を指定することができます。

```bash
lsblk -o NAME,SIZE,FSUSE%
```

指定できる項目一覧は。
```bash
lsblk --list-columns
```
で確認できます。

出力されたNAMEのうち、`vda`が全体のストレージに対応します。

## CPUの使用状況の確認
`vmstat`コマンドで確認可能。cpuの欄がCPUの使用状況を表している。
全体からidを引いたものが使用しているCPUの割合に相当する。

## rebootした日付、日時の確認
`who -b`コマンドで確認可能。

## LVMの使用状況の確認
`/dev/mapper`にある`control`以外の数だけLVMが作成されている。この数を`ls`コマンドと`wc -l`コマンドで確認すればいける。

## 接続している数の確認
`ss -tn status established`コマンドで一覧表示されれう。

## 接続中のユーザの数の確認
`w`コマンドで一覧表示される。

## ipアドレスの確認
IPv4は、`ip -4 a`コマンドで確認可能。

## sudoコマンドの使用履歴
`/var/log/sudo/sudo.log`で確認可能。

## 10分おきに実行
`ctonrab -e`で開いて、`*/5 * * * * /home/tsugimot/monitoring.sh`を追記