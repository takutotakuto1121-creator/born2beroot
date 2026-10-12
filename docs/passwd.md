# パスワードポリシーの設定
## /etc/login.defs
パスワードポリシーを設定できるファイル。
```bash
sudo nano /etc/login.defs
```
で開きます。

`PASS_MAX_DAYS`, `PASS_MIN_DAYS`, `PASS_WARN_AGE`が枯れている部分を探し、以下のように書き換えます。
```
PASS_MAX_DAYS   30
PASS_MIN_DAYS   2
PASS_WARN_AGE   7
```
`PASS_MAX_DAYS`は、指定した数字の日の間に少なくとも１回パスワードを変更しなければならないというルールを定める部分です。

`PASS_MIN_DAYS`は、一度パスワードを変更してから指定した日付の間はパスワードを変更できないというルールを定める部分です。

`PASS_WARN_AGE`は、指定した日に一回パスワードを変更してくださいという警告を表示するルールを定める部分です。

## /etc/security/pwquality.conf
まずは以下のパッケージをインストールしてください
```bash
sudo apt install -y lipam-pwquality
```

すると、`/etc/security/pwquality.conf`を設定できるようになります。
```bash
sudo nano /etc/security/pwquality.conf
```
で開いて、以下のように設定してください。

```conf
# Number of characters in the new password that must not be present in the
# old password.
difok = 7

# Minimum acceptable size for the new password (plus one if
# credits are not disabled which is the default). (See pam_cracklib manual.)
# Cannot be set to lower value than 6.
minlen = 10

# The maximum credit for having digits in the new password. If less than 0
# it is the minimum number of digits in the new password.
dcredit = -1

# The maximum credit for having uppercase characters in the new password.
# If less than 0 it is the minimum number of uppercase characters in the new
# password.
ucredit = -1

# The maximum credit for having lowercase characters in the new password.
# If less than 0 it is the minimum number of lowercase characters in the new
# password.
lcredit = -1

# The maximum number of allowed consecutive same characters in the new password.
# The check is disabled if the value is 0.
maxrepeat = 3

# Whether to check if it contains the user name in some form.
# The check is enabled if the value is not 0.
usercheck = 1

# Enforces pwquality checks on the root user password.
# Enabled if the option is present.
enforce_for_root
```

それぞれの項目の意味は、デフォルトでコメントで書かれている通りです。

`enforce_for_root`について、すべての項目がrootのパスワードポリシーにも含まれるように感じますが、`disfok`のみは含まれないような仕様になっています。

### パスワードの変更
`passewd`コマンドでパスワードを変更することができる。
以下のコマンドで、ユーザ、ルートのパスワードを変更できる。
パスワードポリシーに違反している場合はエラーメッセージが表示される。

```bash
passwd [ユーザ名]
passwd root
```
