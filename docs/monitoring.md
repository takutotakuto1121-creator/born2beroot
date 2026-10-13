# monitoring.sh
## パイプ、grepコマンド、awkコマンド
`monitoring.sh`では、各情報を閲覧できるコマンドに対して、パイプで`grep`コマンドや`awk`コマンドなどを用いて必要な箇所だけを抜き出す方法を選択しています。

### パイプ |
bashのコマンドはパイプと呼ばれる`|`で区切ることにより、出力を標準入力として他のコマンドに送ることができます。
例えば以下のようにすると、

```bash
sudo cat /etc/sudoers | grep Default
```

catで出力できた`/etc/sudoers/`のうち、行内にDefaultが含まれる行のみを表示させることができます。

### grepコマンド
`grep`コマンドは、指定したファイルのうち、指定した文字列だけを含む行を抽出して出力してくれるコマンドです。

```bash
grep [オプション] [文字列] [ファイル名]
```

のように使用します。この`grep`に標準入力でファイル送ってあげると、パイプの例にあるような使い方になります。

```bash
[コマンド] | grep "^NAME"
```

以上のように文字列の先頭に`^`をつけると、行頭が`NAME`で始まる列のみを抽出できます。

### awkコマンド
`awk`コマンドは、入力テキストを1行ずつ読み込み、各行をフィールドと呼ばれる列に分解し、パターンにマッチするか確認し、マッチした場合対応するアクションを実行します。基本構文は以下です。

```bash
awk [オプション]　'パターン {アクション}' ファイル名
```

ただ、`awk`コマンドはそれ自体がプログラミング言語で、奥が深いので今回は以下の要素を使用できれば十分です。

```bash
# コマンドの出力結果をスペースで区切り、そのうちの1つ目のみを表示する
[コマンド] | awk '{print $1}`'

# 四則演算をして、その結果を出力する
awk `BEGIN {print 3 + 2 - 1 * 1 / 3}
```

## OSのアーキテクチャとカーネルのバージョンの確認
以下のコマンドで確認可能です。`monitoring.sh`では、`uname -a`を使用しています。

```bash
cat /proc/version
uname -a
```

よって、`monitoring.sh`では以下のようにしています。

```bash
Architecture=$(uname -a)
```

## 物理CPU(physical CPU)数と仮想CPU(Virtual CPU)数の確認
以下のコマンドで確認可能です。

```bash
cat /proc/cpuinfo   # processorが仮想CPUの数、physical isが物理CPUの数
lscpu   # CPU(s)が仮想CPUの数、Socket(s)が物理CPUの数
nproc   # 仮想CPUの総数のみ
```

よって、`monitoring.sh`では以下のようにしています。

```bash
Physical_CPU=$(lscpu | grep "^Socket" | awk '{print $2}')
Virtual_CPU=$(nproc)
```

## RAMの使用状況の確認
`free`コマンドと`top`コマンドで確認可能です。`monitoring.sh`では`free`コマンドを使用しています。

`free`コマンドの出力結果のうち、`Mem`の行がメモリの使用状況を表しています。そのうち`total`がRAMの全体量で、`used`が現在使用している量です。
そのため、`monitoring.sh`では以下のようにしています。

```bash
RAM_total=$(free | grep "^Mem:" | awk '{print $2}')
RAM_used=$(free | grep "^Mem:" | awk '{print $3}')
RAM_percent=$(awk "BEGIN {print $RAM_used / $RAM_total * 100}")
```

## ストレージの使用状況の確認
`df`コマンド, `lsblk`コマンドで確認できます。

`df`コマンドは、`df -h`としてオプションをつけることにより、人間が読みやすい形式で出力されます。

マウントポイントが/(root)の場所を見れば全体のサイズが見れますが、LVMでパーティション分割をしている場合はここにあるものが全てではありません。

`--total`オプションをつけることにより最後の行に合計が出力されます。

```bash
df -h --total
```

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

今回は`df`コマンドを使用しました。

```bash
storage_total=$(df -h -m --total | grep "^total" | awk '{print $2}')
storage_used=$(df -h -m --total | grep "^total" | awk '{print $3}')
storage_percent=$(awk "BEGIN {print $storage_used / $storage_total * 100}")
```

## CPUの使用状況の確認
`vmstat`コマンドで確認可能。cpuの欄がCPUの使用状況を表しています。
全体からidを引いたものが使用しているCPUの割合に相当します。よって以下のようにしています。

```bash
PU_id=$(vmstat | grep -v -e "procs" -e "r" | awk '{print $15}')
CPU_utilization=$(awk "BEGIN {print 100 - $CPU_id}")
```

## rebootした日付、日時の確認
`who -b`コマンドで確認可能。
よって以下のようにしています。

```bash
reboot_date=$(who -b | awk '{print $3}')
reboot_time=$(who -b | awk '{print $4}')
```

## LVMの使用状況の確認
`/dev/mapper`にある`control`以外の数だけLVMが作成されています。この数を`ls`コマンドと`wc -l`コマンドで確認すればいけます。
このLVMの数が2以上になればいいので、条件分岐を用いて以下のようにしています。

```bash
LVM_count=$(ls /dev/mapper | wc -w)

if [ "$LVM_count" -gt 2 ]; then
    LVM_use="yes"
else
    LVM_use="no"
fi
```

## 接続している数の確認
`ss -tn status established`コマンドで一覧表示されます。抽出すると以下のようになります。
```bash
connection_num=$(ss -tn state established | grep -v "^Recv-Q" | wc -l)
```

## 接続中のユーザの数の確認
`w`コマンドで一覧表示される。よってその数を数えれればいいので、以下のようにしている。

```bash
user_num=$(w | grep "users" | awk '{print $5}')
```

## ipアドレスの確認
IPv4は、`ip -4 a`コマンドで確認可能。
以下のように必要部分だけを抜き出します。

```bash
ip_v4=$(ip -4 a | grep inet | tr '\n' ' ' | awk '{print $2}' | tr '/' '\n' | head -n 1)
```

## sudoコマンドの使用履歴
`/var/log/sudo/sudo.log`で確認可能。`COMMAND`の行だけを抜き出してその数をカウントすれば、使用された回数がわかるので以下のようにしています。

```bash
sudo_num=$(cat /var/log/sudo/sudo.log | grep COMMAND | wc -l)
```

## 全ターミナルへの送信
`wall`コマンドを用いれば、全ターミナルに何かしらの文章を表示させることができます。

## 起動時と10分おきに実行
### cron
linuxの**cron**は、指定した日時や周期でプログラムやシェルスクリプトを自動的に実行するためのプログラムです。

### 書式
設定ファイルである`crontab`には、以下の５つの時刻指定と実行コマンドを記述します。
```
分 時 日 月 曜日 コマンド
```

### 編集
`crontab -e`で開けます。開いて、

```bash
*/10 * * * * /home/tsugimot/monitoring.sh
```

を追記すると、10分おきに`monitoring.sh`が実行されます。

```bash
@reboot /home/tsugimot/monitoring.sh
```

を追記すると、起動時に`monitoring.sh`が表示されますが、これは起動してからパスワードを打つ前に全てのターミナルに表示されるので、この時点では表示するターミナルがなく、`monitoring.sh`は実行されているので課題要件は満たしていますが、分かりやすく表示はされません。

そのため、以下のようにして時間差でスクリプトが実行されるような設定にしていれば分かりやすくはなります。

```bash
@reboot sleep 60 && /home/tsugimot/monitoring.sh
```

## monitoring.sh
以上を踏まえて、以下のようなスクリプトにしています。

```bash
#!/bin/bash

Architecture=$(uname -a)
Physical_CPU=$(lscpu | grep "^Socket" | awk '{print $2}')
Virtual_CPU=$(nproc)
RAM_total=$(free | grep "^Mem:" | awk '{print $2}')
RAM_used=$(free | grep "^Mem:" | awk '{print $3}')
RAM_percent=$(awk "BEGIN {print $RAM_used / $RAM_total * 100}")
storage_total=$(df -h -m --total | grep "^total" | awk '{print $2}')
storage_used=$(df -h -m --total | grep "^total" | awk '{print $3}')
storage_percent=$(awk "BEGIN {print $storage_used / $storage_total * 100}")
CPU_id=$(vmstat | grep -v -e "procs" -e "r" | awk '{print $15}')
CPU_utilization=$(awk "BEGIN {print 100 - $CPU_id}")
reboot_date=$(who -b | awk '{print $3}')
reboot_time=$(who -b | awk '{print $4}')
LVM_count=$(ls /dev/mapper | wc -w)
connection_num=$(ss -tn state established | grep -v "^Recv-Q" | wc -l)
user_num=$(w | grep "users" | awk '{print $5}')
ip_v4=$(ip -4 a | grep inet | tr '\n' ' ' | awk '{print $2}' | tr '/' '\n' | head -n 1)
mac_adress=$(ip link show | grep link/ether | awk '{print $2}')
sudo_num=$(cat /var/log/sudo/sudo.log | grep COMMAND | wc -l)
date_now=$(date)

if [ "$LVM_count" -gt 2 ]; then
    LVM_use="yes"
else
    LVM_use="no"
fi

wall "
    #Architecture: $Architecture
    #Physical CPU: $Physical_CPU
    #vCPU: $Virtual_CPU
    #Memory Usage: $RAM_used/$RAM_total ($RAM_percent%)
    #Disk Usage: $storage_used/$storage_total ($storage_percent%)
    #CPU load: $CPU_utilization%
    #Last boot: $reboot_date $reboot_time
    #LVM use: $LVM_use
    #TCP Connections: $connection_num ESTABLISHED
    #User log: $user_num
    #Network: IP $ip_v4 ($mac_address)
    #Sudo: $sudo_num cmd
"
```