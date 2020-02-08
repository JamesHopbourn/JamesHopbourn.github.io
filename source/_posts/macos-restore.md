---
title: macOS restore
date: 2020-02-08 22:53:00
tags: macOS
---

U 盘里存储：iTerm2、Surge、Spectacle
1Password 里存储：SSH、GPG 私钥
iPhone 内存储：Surge 配置文件
以上三个 airdrop 传输给 macOS

<!-- more -->

## ZSH
```
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

sed -i '' '201s/%~/%c/' ~/.oh-my-zsh/themes/agnoster.zsh-theme

sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

cd ~/Library/Fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf && cd -
```

## Homebrew
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask
brew tap homebrew/cask-fonts
```

## SpaceVim
```
curl -sLf https://spacevim.org/cn/install.sh | bash

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## Brew
```
brew install pigz gnu-tar zip unzip unrar p7zip rmtrash coreuntil stow highlight
hexyl gpg gnu-sed autojump hub git vim  
```

## dotfile
```
git clone ssh://personal/JamesHopbourn/dotfile ~/potfile
stow ~/potfile/home
```

至于为什么是 potfile 而不是 dotfile，因为 zsh 补全输入 d 会显示：Downloads、Desktop、dotfile 麻烦，就直接 potfile 了

## GPG
```
gpg --import secret-backup.gpg
gshred -f -v -z -u --iterations=36 secret-backup.gpg
gshred -f -v -z -u --iterations=36 ~/Downloads/*.txt
```

## WeChat
```
git clone https://github.com/Sunnyyoung/WeChatTweak-macOS.git /tmp/WeChatTweak-macOS && cd /tmp/WeChatTweak-macOS && sudo make install && cd -
```

## gem
```
gem install colorls --user
```

## Security
```
sudo spctl --master-disable
```

