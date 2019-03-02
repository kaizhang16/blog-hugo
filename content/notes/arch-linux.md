---
title: "Arch Linux"
date: 2018-10-28T16:05:48+08:00
markup: "pandoc"
description: "安装配置 Arch Linux 的笔记。"
---

# 安装

## 确认 boot 模式

```
# ls /sys/firmware/efi/efivars
```

存在时为 UEFI 模式，不存在则为 BIOS 模式。

## 确认已联网

```
# ping archlinux.org
```

## 更新系统时钟

```
# timedatectl set-ntp true
```

## 分区

### BIOS boot 分区

> 在 BIOS/GPT 配置下才需要。

```
# gdisk /dev/sda  # 选 GPT 分区表
n
回车（使用默认值）
+1M
ef02
w
```

### LVM 分区

#### 创建分区

```
# gdisk /dev/sda
n
回车（使用默认值）
回车（使用默认值）
8e00
w
```

#### 创建 physical volumes

```
# lvmdiskscan
# pvcreate /dev/sda2
# pvdisplay
```

#### 创建 volume group

```
# vgcreate VolGroup00 /dev/sda2
# vgdisplay
```

#### 创建 logical volumes

```
# lvcreate -L 30G VolGroup00 -n lvroot
# lvcreate -L 20G VolGroup00 -n lvvar
# lvcreate -l 100%FREE VolGroup00 -n lvhome
# lvdisplay
```

#### 创建文件系统和挂载 logical volumes

```
mkfs.ext4 /dev/VolGroup00/lvroot
mkfs.ext4 /dev/VolGroup00/lvvar
mkfs.ext4 /dev/VolGroup00/lvhome
mkdir /mnt/var
mkdir /mnt/home
mkdir /mnt/hostrun
mount /dev/VolGroup00/lvroot /mnt
mount /dev/VolGroup00/lvvar /mnt/var
mount /dev/VolGroup00/lvhome /mnt/home
mount --bind /run /mnt/hostrun
```

## 安装 base packages

```
# pacstrap /mnt base
```

## 配置

### Fstab

```
# genfstab -U /mnt >> /mnt/etc/fstab
```

### Chroot

Change root 到新系统：

```
# arch-chroot /mnt
# pacman -S vim
```

### 时区

```
# ln -sh /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# hwclock --systohc
```

### 本地化

去掉 `/etc/locale.gen` 里 `en_US.UTF-8 UTF-8` 和 `zh_CN.UTF-8 UTF-8` 两行的注释符号，然后：

```
# locale-gen
# echo "LANG=en_US.UTF-8" >> /etc/locale.conf
# echo "hostname" >> /etc/hostname
# echo "127.0.0.1 localhost" >> /etc/hosts
# echo "::1       localhost" >> /etc/hosts
```

### Initramfs

```
File: /etc/mkinitcpio.conf
--------------------------------------------
HOOKS=(base **udev** ... block **lvm2** filesystems)
```

```
# mkinitcpio -p linux
```

### 根用户密码

```
# passwd
```

### Boot loader

```
# mkdir /run/lvm
# mount --bind /hostrun/lvm /run/lvm
# pacman -S grub
# grub-install --target=i386-pc /dev/sda
# vim /etc/default/grub  # 在 GRUB_PRELOAD_MODULES='...' 里加入 lvm
# grub-mkconfig -o /boot/grub/grub.cfg
```

## 退出

```
# exit
# umount -R /mnt
# reboot
```

# 基础

## DNS

```
# systemctl enable dhcpcd
# systemctl start dhcpcd
# pacman -S fish git sudo
```

## 用户

```
# useradd --create-home kai
# passwd kai
# gpasswd -a kai wheel
# pacman -S fish vim
# visudo  # 让 wheel 拥有 sudo 权限
# chsh -s /usr/bin/fish kai
```

## Virtual Box

```
sudo pacman -S virtualbox-guest-utils  # 选择 virtualbox-guest-modules-arch
sudo gpasswd --add kai vboxsf
sudo systemctl enable vboxservice
sudo systemctl start vboxservice
```

如果不能全屏的话，可能是分辨率的问题，请添加以下文件：

```
File: /etc/X11/xorg.conf.d/10-monitor.conf
-------------------------------------------
Section "Monitor"
  Identifier "Virtual-1"
  Modeline "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
  Option "PreferredMode" "1920x1080_60.00"
EndSection
```

> Modeline 那一行由 `cvt 1920 1080` 生成。

## yay

```
mkdir ~/projects && cd ~/projects
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

## X11

> 安装 `xorg-server` 时选默认的依赖。

```
sudo pacman -S adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts
sudo pacman -S adobe-source-code-pro-fonts
sudo pacman -S alacritty base-devel bat clang dmenu
sudo pacman -S fd feh firefox fzf gopass
sudo pacman -S i3-gaps
sudo pacman -S parcellite powerline-fonts ranger ripgrep
sudo pacman -S tmux tmuxp transset-df tree
sudo pacman -S ttf-dejavu ttf-font-awesome ttf-inconsolata ttf-roboto
sudo pacman -S variety w3m wqy-microhei wqy-zenhei
sudo pacman -S xclip xcompmgr xorg-server xorg-xinit xsel
yay i3lock-next i3status-rust ttf-font-awesome-4
```

## dotfiles

```
sudo pacman -S rustup
rustup install beta
rustup default beta

mkdir ~/projects/my && cd ~/projects/my
git clone https://github.com/kaizhang91/dotfiles.git
cd dotfiles/
cargo build --release
./target/release/dotfiles templates/
```

## fish

```
yay fisher  # fish plugin manager
fisher add jethrokuan/z  # 安装 z
```

## 输入法

```
sudo pacman -S fcitx fcitx-cloudpinyin fcitx-googlepinyin
sudo pacman -S fcitx-im  # 选择全部
```

## 下载

```
sudo pacman -S uget
yay uget-integrator uget-integrator-firefox
```

## 翻译

```
sudo pacman -S goldendict
```

## 文档

```
sudo pacman -S zeal
```

## 排版

```
sudo pacman -S graphviz
sudo pacman -S pandoc-citeproc pandoc-crossref
sudo pacman -S texlive-most
sudo pacman -S texlive-lang
```

### 字体

```
mkdir -p ~/.local/share/fonts
cp -i ~/share/fonts/方正苏新诗柳楷简体.ttf ~/.local/share/fonts/
cp -i ~/share/fonts/方正苏新诗柳楷繁体.ttf ~/.local/share/fonts/
fc-list | grep -i kai
```

## 其他

```
pacman -S deepin-screenshot emacs
pacman -S go hugo mplayer net-tools
pacman -S openssh pavucontrol python stack
pacman -S rxvt-unicode
pacman -S tcpdump yarn
yay google-chrome
```

# 编程语言

## c/c++

```
sudo pacman -S cmake
```

## Lua

```
sudo pacman -S luarocks
```

## Python

### Jupyter

```
sudo pacman -S jupyter-notebook
sudo jupyter nbextension enable --py --sys-prefix widgetsnbextension
```

### 数据挖掘

```
sudo pacman -S python-matplotlib python-pandas
```

## Rust

```
rustup component add clippy rustfmt rust-src
```

## 前端

```
yarn config set registry https://registry.npm.taobao.org --global
yarn global add elm
```

# 归档

## neovim

```
sudo pacman -S neovim python-isort python-neovim python2-neovim
sudo pacman -S rust-racer vim-jedi yapf
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## Spacemacs

### Haskell

```
sudo pacman -S hlint stylish-haskell hasktags hoogle
yay haskell-apply-refactor
stack install intero
```

## SpaceVim

```
sudo pacman -S neovim python-neovim python2-neovim
curl -sLf https://spacevim.org/install.sh | bash
```

## zsh

```
sudo pacman -S z zsh
git clone https://github.com/Tarrasch/antigen-hs.git ~/.zsh/antigen-hs/
# 修改 stack.yaml 里的 resolver 版本
zsh  # Yes, Yes ...
# 更新 MyAntigen.hs 后，请 antigen-hs-setup
```