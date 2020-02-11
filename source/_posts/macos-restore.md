---
title: macOS restore
date: 2020-02-08 22:53:00
tags: macOS
---

U 盘里存储：iTerm2、Surge、Spectacle、Surge 配置文件
1Password 里存储：SSH、GPG 私钥
以上两个 airdrop 传输给 macOS

<!-- more -->

## Surge proxy
```
export https_proxy=http://127.0.0.1:6152;export http_proxy=http://127.0.0.1:6152;export all_proxy=socks5://127.0.0.1:6153
```

## Homebrew
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew tap homebrew/cask-fonts

brew install lsd gpg rmtrash coreutils stow pigz gnu-tar zip unzip unrar p7zip highlight hexyl hub git vim icdiff fzf 

brew cask install keka sublime-text gpg-suite veracrypt font-source-code-pro adguard
```

## ZSH
```
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

sed -i '' '201s/%~/%c/' ~/.oh-my-zsh/themes/agnoster.zsh-theme

sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

cd ~/Library/Fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf && cd -
```

## pip
```
sudo easy_install pip

pip install powerline-status --user
```

## SpaceVim
```
curl -sLf https://spacevim.org/cn/install.sh | bash

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## GPG
```
gpg --import ~/Downloads/secret-backup.gpg

gshred -f -v -z -u --iterations=36 ~/Downloads/*
```

## dotfile
```
git clone ssh://james/JamesHopbourn/dotfile ~/potfile

stow ~/potfile/home

source ~/.zshrc

rm ~/Library/Preferences/com.googlecode.iterm2.plist

cp ~/potfile/com.googlecode.iterm2.plist ~/Library/Preferences/
```

## WeChat
```
git clone https://github.com/Sunnyyoung/WeChatTweak-macOS.git /tmp/WeChatTweak-macOS && cd /tmp/WeChatTweak-macOS && sudo make install && cd -
```

## crontab
```
@reboot say 'Welcome back James'
```

## macOS 
```
sudo spctl --master-disable
sudo killall -STOP -c usbd
sudo nvram SystemAudioVolume=%00
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
```

## Sublime Text
```
"font_size": 20,
"font_face": "SourceCodePro-Semibold",
```
