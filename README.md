*This project has been created as part of the 42 curriculum by tsugimot.*
# Born2beroot
## Description
Born2berootは、42cursusのMilestone2のソロ課題です。仮想マシンをセットアップし、LVM, SSH, fire wall, user, group, password policy, sudoなどの設定を行います。また、10分おきに特定の動作をするシェルスクリプトを作成します。以上により、Linuxサーバの基礎を学ぶ課題です。今回はDebianを用いています。

## Instructions
以下の手順で課題を進めていきます。
今回は知識系の課題なので、解説を記述しています。
1. [Linux, VMについて](docs/linux_vm.md)
2. [VirtualBox](docs/virtualbox.md), [UTM](docs/UTM.md)のセットアップ
3. [Debianのインストール](docs/debian.md)
4. [sudoの設定](docs/sudo.md)
5. [sshの設定](docs/ssh.md)
6. [ユーザとグループ](docs/user_group.md)
7. [パスワードポリシーの設定](docs/passwd.md
)
8. [monitoring.shの作成](docs/monitoring.md)
9. [signature.txtの作成](docs/signature.md)

## Resources
### AIの使用
学習のため、基本的にAIは使用していません。UTMにおける`signature.txt`の作成の手助けにのみAIを使用しました。
### 参考文献
https://www.kagoya.jp/howto/engineer/itsystem/virtualization/
https://www.kagoya.jp/howto/it-glossary/server/vm_guest_host/
https://www.kagoya.jp/howto/engineer/itsystem/hci/
https://www.kagoya.jp/howto/cloud/container/container-03/
https://www.kagoya.jp/howto/cloud/container/docker/
https://qiita.com/Sicut_study/items/4f301d000ecee98e78c9
https://www.virtualbox.org/?_fsi=NvwJtcAr
https://www.famlog.jp/article/4873
https://techmania.jp/blog/debian/
https://www.mintjams.jp/Linux%E3%82%BB%E3%82%AD%E3%83%A5%E3%83%AA%E3%83%86%E3%82%A3%E3%81%AE%E6%96%B0%E5%B8%B8%E8%AD%98%EF%BC%9ASELinux%E3%81%A8AppArmor%E3%81%AE%E5%9F%BA%E7%A4%8E%E3%81%A8%E5%9B%B0%E3%81%A3%E3%81%9F%E6%99%82%E3%81%AE%E5%AF%BE%E5%87%A6%E6%B3%95/r/help%2Clinux_management_and_operation_basics%2C40.html/
https://www.linuxmaster.jp/linux_skill/2026/06/linux-intro-distro-selection.html
https://linuc.org/study/column/6826/
https://docs.redhat.com/ja/documentation/red_hat_enterprise_linux/6/html/storage_administration_guide/ch-lvm1
https://www.bureau-mikami.jp/%E3%80%90%E5%88%9D%E5%BF%83%E8%80%85%E5%90%91%E3%81%91%E3%80%91debian-ubuntu%E3%81%A7%E3%81%AE%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E7%AE%A1%E7%90%86%E3%81%AFapt%EF%BC%9Faptitude%EF%BC%9F/
https://www.mintjams.jp/Linux%E3%82%BB%E3%82%AD%E3%83%A5%E3%83%AA%E3%83%86%E3%82%A3%E3%81%AE%E6%96%B0%E5%B8%B8%E8%AD%98%EF%BC%9ASELinux%E3%81%A8AppArmor%E3%81%AE%E5%9F%BA%E7%A4%8E%E3%81%A8%E5%9B%B0%E3%81%A3%E3%81%9F%E6%99%82%E3%81%AE%E5%AF%BE%E5%87%A6%E6%B3%95/r/help%2Clinux_management_and_operation_basics%2C40.html/
https://www.server-world.info/query?os=Debian_12&p=hostname
https://qiita.com/yasushi-jp/items/78d5965c1624b1529ff6
https://qiita.com/Jochun/items/56b90918f4590f4501b5
https://qiita.com/Jochun/items/56b90918f4590f4501b5
https://qiita.com/orangain/items/056db6ffc16d765a8187
https://www.server-world.info/query?os=Ubuntu_24.04&p=pam&f=1
https://note.com/yutaworklife/n/n8ad6ab015cd0
https://labex.io/ja/tutorials/linux-how-to-enforce-password-complexity-policies-in-linux-414805
https://www.server-world.info/query?os=Debian_10&p=password
https://manpages.debian.org/testing/login/login.defs.5.ja.html
https://www.ionos.com/digitalguide/server/know-how/cpu-vs-vcpu/
