---
title: "Arch Linux"
date: 2018-10-28T16:05:48+08:00
markup: "pandoc"
description: "安装配置 Arch Linux 的笔记。"
---

## 安装

### 分区

分区方案：

- `/`: 20 GB
- `/var`: 15 GB
- `/home`: 45 GB

```
fdisk /dev/sda  # 选 dos 分区表

mkfs.ext4 /dev/sda1
```

### 时区

```
ln -sh /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
```

### boot

```
pacman -S grub
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
```

## 基础

### 用户

```
useradd --create-home kai
passwd kai
gpasswd -a kai wheel
visudo  # 让 wheel 拥有 sudo 权限
chsh -s /usr/bin/zsh kai
```

### Virtual Box

```
sudo pacman -S virtualbox-guest-utils  # 选择 virtualbox-guest-modules-arch
sudo gpasswd --add kai vboxsf
sudo systemctl start vboxservice
sudo systemctl enable vboxservice
```

### yay

```
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

### X11

```
sudo pacman -S alacritty fzf tmux tmuxp trayer xcompmgr transset-df
yay i3lock-next
```

### fish

```
sudo pacman -S fish
yay fisher  # fish plugin manager
fisher add jethrokuan/z  # 安装 z
```

### neovim

```
sudo pacman -S neovim python-neovim rust-racer
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### zsh

```
git clone https://github.com/Tarrasch/antigen-hs.git ~/.zsh/antigen-hs/
# 修改 stack.yaml 里的 resolver 版本
zsh  # Yes, Yes ...
# 更新 MyAntigen.hs 后，请 antigen-hs-setup
```

### zeal

```
sudo pacman -S zeal
```

### 下载

```
sudo pacman -S uget
yay uget-integrator uget-integrator-firefox
```

### 翻译

```
sudo pacman -S goldendict
```

### 排版

```
sudo pacman -S graphviz
sudo pacman -S pandoc-citeproc pandoc-crossref
sudo pacman -S texlive-most
sudo pacman -S texlive-lang
```

### Rust

```
sudo pacman -S rustup
rustup install stable
rustup component add rust-src
rustup component add rustfmt-preview
```

### 其他

```
systemctl start dhcpcd
systemctl enable dhcpcd
pacman -S adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts
pacman -S adobe-source-code-pro-fonts
pacman -S base-devel deepin-screenshot dmenu emacs
pacman -S fcitx fcitx-cloudpinyin fcitx-googlepinyin
pacman -S fcitx-im  # 选择全部
pacman -S fd feh
pacman -S git go gopass hugo mplayer pavucontrol net-tools
pacman -S openssh parcellite python stack sudo
pacman -S ranger ripgrep rust rxvt-unicode tree
pacman -S ttf-dejavu ttf-font-awesome ttf-inconsolata ttf-roboto
pacman -S variety tcpdump vim w3m wqy-microhei wqy-zenhei
pacman -S xclip xmobar xmonad xorg-server xorg-xinit
pacman -S xsel yarn z zsh
yay google-chrome
```

## 配置

### Spacemacs

#### Haskell

```
sudo pacman -S hlint stylish-haskell hasktags hoogle
yay haskell-apply-refactor
stack install intero
```

#### Python

```
sudo pacman -S flake8 yapf
```

### 前端

```
yarn config set registry https://registry.npm.taobao.org --global
yarn global add elm
```
