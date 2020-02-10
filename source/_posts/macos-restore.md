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

brew install gpg rmtrash coreutils stow pigz gnu-tar zip unzip unrar p7zip highlight hexyl gnu-sed autojump hub git vim icdiff fzf 

brew cask install keka sublime-text gpg-suite veracrypt font-source-code-pro adguard
```

## ZSH
```
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

sed -i '' '201s/%~/%c/' ~/.oh-my-zsh/themes/agnoster.zsh-theme

sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

cd ~/Library/Fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf && cd -

curl https://gist.githubusercontent.com/gnachman/4cbe6743baa7fe07536b/raw/61fceba4a0b2624850ac1b4a20ac8ca48e07f7d2/gistfile1.txt|pbcopy
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
gpg --import secret-backup.gpg

gshred -f -v -z -u --iterations=36 secret-backup.gpg

gshred -f -v -z -u --iterations=36 ~/Downloads/*.txt
```

## dotfile
```
git clone ssh://personal/JamesHopbourn/dotfile ~/potfile

stow ~/potfile/home
```

## WeChat
```
git clone https://github.com/Sunnyyoung/WeChatTweak-macOS.git /tmp/WeChatTweak-macOS && cd /tmp/WeChatTweak-macOS && sudo make install && cd -
```

## gem
```
gem install travis --user
gem install colorls --user
```

## crontab
```
@reboot say 'Welcome back James'
```

## macOS 
```
sudo spctl --master-disable
sudo killall -STOP -c usbd
sudo nvram SystemAudioVolume=" "
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
```

## Sublime Text
```
	"font_face": "SourceCodePro-Semibold",
```
