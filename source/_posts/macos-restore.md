---
title: macOS restore
date: 2020-02-08 22:53:00
tags: macOS
---

系统 U 盘里存储：
- Surge
- iTerm2
- Spectacle
- Surge 配置文件
- Command Line Tools.dmg
- SSH、GPG 私钥、账号密码加密压缩包

<!-- more -->

## Applications
```
cp -r /Volumes/Catalina/软件/* /Applications
cp -r /Volumes/Catalina/Surge ~/Documents
unzip /Volumes/Catalina/Restore/SSH.zip
```

## Surge proxy
```
export https_proxy=http://127.0.0.1:6152;export http_proxy=http://127.0.0.1:6152;export all_proxy=socks5://127.0.0.1:6153
```

## Command Line Tools
```
hdiutil attach /Volumes/Catalina/Restore/Command_Line_Tools_for_Xcode_11.3.1.dmg

sudo installer -pkg /Volumes/Command\ Line\ Developer\ Tools/Command\ Line\ Tools.pkg  -target /

hdiutil unmount /Volumes/Command\ Line\ Developer\ Tools
```

## Homebrew
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew tap homebrew/cask-fonts

brew tap homebrew/bundle

brew install lsd gpg rmtrash coreutils stow pigz gnu-tar zip unzip unrar p7zip highlight hexyl hub git vim icdiff fzf 

brew cask install keka sublime-text gpg-suite veracrypt font-source-code-pro adguard
```

## ZSH
```
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

sed -i '' '201s/%~/%c/' ~/.oh-my-zsh/themes/agnoster.zsh-theme

sed -i '' '39s/google/gg/' ~/.oh-my-zsh/plugins/web-search/web-search.plugin.zsh

sed -i '' '44s/github/gh/' ~/.oh-my-zsh/plugins/web-search/web-search.plugin.zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

cd ~/Library/Fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf && cd -

vim ~/.oh-my-zsh/themes/agnoster.zsh-theme +90
d5d
o
```

```
prompt_context() {
  emojis=("⚡️" "🔥" "💀" "👑" "😎" "🐸" "🐵" "🦄" "🌈" "😄" "🚀" "💡" "🎉" "🔑" "🇹🇭" "🚦" "🌙")
  RAND_EMOJI_N=$(( $RANDOM % ${#emojis[@]} + 1))
  prompt_segment magent black "${emojis[$RAND_EMOJI_N]} "
}
```

```
[ESC]
o
[ESC]
:wq
```

![](/media/200212iterm.png)
## pip
```
sudo easy_install pip

pip install powerline-status --user
```

## SpaceVim
```
curl -sLf https://spacevim.org/cn/install.sh | bash
```

## GPG
```
gpg --import /Volumes/Catalina/Restore/secret-backup.gpg
```

## dotfile
```
git clone ssh://james/JamesHopbourn/dotfile ~/potfile

chflags hidden ~/potfile

stow ~/potfile/home

source ~/.zshrc

cp ~/potfile/com.googlecode.iterm2.plist ~/Library/Preferences/
```

## WeChat
```
git clone https://github.com/Sunnyyoung/WeChatTweak-macOS.git /tmp/WeChatTweak-macOS && cd /tmp/WeChatTweak-macOS && sudo make install && cd -
```

## crontab
```
@reboot say 'Welcome back James'
@reboot /Applications/v2ray-macos/v2ray
@reboot sudo python $HOME/dotfile/bin/usbkill.py
@reboot osascript $HOME/dotfile/bin/reminder.scpt

```

## macOS 
```
sudo spctl --master-disable
sudo killall -STOP -c usbd
sudo nvram SystemAudioVolume=%00
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

设置进入休眠状态时马上启动屏幕保护程序
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

launchpad 图标
defaults write com.apple.dock springboard-columns -int 8; defaults write com.apple.dock springboard-rows -int 8; defaults write com.apple.dock ResetLaunchPad -bool TRUE; killall Dock
```

## Sublime Text
```
"font_size": 20,
"font_face": "SourceCodePro-Semibold",
```
