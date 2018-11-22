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
pacman -S fish vim
visudo  # 让 wheel 拥有 sudo 权限
chsh -s /usr/bin/fish kai
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
sudo pacman -S adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts
sudo pacman -S adobe-source-code-pro-fonts
sudo pacman -S alacritty dmenu feh fzf
sudo pacman -S parcellite ranger
sudo pacman -S tmux tmuxp trayer transset-df
sudo pacman -S ttf-dejavu ttf-font-awesome ttf-inconsolata ttf-roboto
sudo pacman -S variety w3m wqy-microhei wqy-zenhei
sudo pacman -S xclip xcompmgr xmobar xmonad xorg-server xorg-xinit xsel
yay i3lock-next
```

### fish

```
yay fisher  # fish plugin manager
fisher add jethrokuan/z  # 安装 z
```

### neovim

```
sudo pacman -S neovim python-isort python-neovim python2-neovim
sudo pacman -S rust-racer vim-jedi yapf
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### dotfiles

```
sudo pacman -S rustup
rustup install beta
rustup default beta
rustup component add clippy-preview rustfmt-preview rust-src

mkdir ~/projects && cd ~/projects
git clone https://github.com/kaizhang91/dotfiles.git
cd dotfiles/
cargo build --release
./target/release/dotfiles templates/
```

### zsh

```
sudo pacman -S z zsh
git clone https://github.com/Tarrasch/antigen-hs.git ~/.zsh/antigen-hs/
# 修改 stack.yaml 里的 resolver 版本
zsh  # Yes, Yes ...
# 更新 MyAntigen.hs 后，请 antigen-hs-setup
```

### 输入法

```
sudo pacman -S fcitx fcitx-cloudpinyin fcitx-googlepinyin
sudo pacman -S fcitx-im  # 选择全部
```

### 文档

```
sudo pacman -S zeal
```

### 翻译

```
sudo pacman -S goldendict
```

### 下载

```
sudo pacman -S uget
yay uget-integrator uget-integrator-firefox
```

### 排版

```
sudo pacman -S graphviz
sudo pacman -S pandoc-citeproc pandoc-crossref
sudo pacman -S texlive-most
sudo pacman -S texlive-lang
```

#### 字体

```
mkdir -p ~/.local/share/fonts
cp -i ~/share/fonts/方正苏新诗柳楷简体.ttf ~/.local/share/fonts/
cp -i ~/share/fonts/方正苏新诗柳楷繁体.ttf ~/.local/share/fonts/
fc-list | grep -i kai
```

### 其他

```
systemctl start dhcpcd
systemctl enable dhcpcd
pacman -S base-devel bat deepin-screenshot emacs
pacman -S fd git go gopass hugo mplayer net-tools
pacman -S openssh pavucontrol python stack sudo
pacman -S ripgrep rxvt-unicode tree
pacman -S tcpdump yarn
yay google-chrome
```

## 编程语言

### c/c++

```
sudo pacman -S clang cmake
```

### Python

#### Jupyter

```
sudo pacman -S jupyter-notebook
sudo jupyter nbextension enable --py --sys-prefix widgetsnbextension
```

#### 数据挖掘

```
sudo pacman -S python-matplotlib python-pandas
```

### Spacemacs

#### Haskell

```
sudo pacman -S hlint stylish-haskell hasktags hoogle
yay haskell-apply-refactor
stack install intero
```

### 前端

```
yarn config set registry https://registry.npm.taobao.org --global
yarn global add elm
```
