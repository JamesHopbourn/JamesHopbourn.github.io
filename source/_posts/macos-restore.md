---
title: macOS restore
date: 2020-02-08 22:53:00
tags: macOS
---

系统 U 盘里存储：
- Surge 配置文件
- Surge iTerm2 Spectacle
- homebrew core cask font
- Command Line Tools.dmg
- SSH、GPG 私钥、账号密码加密压缩包

<!-- more -->

## 非必需安全措施
```
恢复模式下开启固件密码
FileVault 磁盘加密
```

## Applications
```
cp -r /Volumes/Catalina/软件/* /Applications

cp -r /Volumes/Catalina/Surge ~/Documents
```

## SSH
```
unzip /Volumes/Catalina/Restore/SSH.zip
```

## Surge proxy
```
export https_proxy=http://127.0.0.1:6152;export http_proxy=http://127.0.0.1:6152;export all_proxy=socks5://127.0.0.1:6153
```

## Command Line Tools
```
hdiutil attach /Volumes/Catalina/Restore/Command_Line_Tools_for_Xcode_11.3.1.dmg;\
sudo installer -pkg /Volumes/Command\ Line\ Developer\ Tools/Command\ Line\ Tools.pkg  -target /;\
hdiutil unmount /Volumes/Command\ Line\ Developer\ Tools;\
say 'Command line tools installed' 
```

## Homebrew
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

cp -r /Volumes/Catalina/homebrew /usr/local/Homebrew/Library/Taps

brew install lsd gnupg rmtrash coreutils stow pigz zip unzip unrar p7zip highlight hexyl hub git vim icdiff fzf duti

brew install findutils gnu-tar gnu-sed gawk gnutls grep

brew cask install font-source-code-pro font-hack-nerd-font

brew cask install sublime-text gpg-suite veracrypt adguard
```

## dotfile
```
ssh -T james;\
git clone ssh://james/JamesHopbourn/dotfile ~/dotfile;\
chflags hidden ~/dotfile;\
mkdir ~/.config/ ~/.lldb ~/.subversion ~/.tmux;\
stow --dir=$HOME/dotfile --ignore='.DS_Store' --target=$HOME home/;\
stow --dir=$HOME/dotfile --ignore='.DS_Store' --target=$HOME/.lldb/ .lldb/;\
stow --dir=$HOME/dotfile --ignore='.DS_Store' --target=$HOME/.tmux/ .tmux/;\
stow --dir=$HOME/dotfile --ignore='.DS_Store' --target=$HOME/.config/ .config/;\
stow --dir=$HOME/dotfile --ignore='.DS_Store' --target=$HOME/.subversion/
.subversion/;\
stow --dir=$HOME/dotfile --ignore='.DS_Store' --target=$HOME/Library/Preferences Preferences
```

## ZSH
```
sh -c "$(curl -fsSL
https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";\
sed -i '' '201s/%~/%c/' ~/.oh-my-zsh/themes/agnoster.zsh-theme;\
sed -i '' '47s/google/gg/' ~/.oh-my-zsh/plugins/web-search/web-search.plugin.zsh;\
sed -i '' '52s/github/gh/' ~/.oh-my-zsh/plugins/web-search/web-search.plugin.zsh;\
curl -o ~/Library/Fonts/"Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf

vim ~/.oh-my-zsh/themes/agnoster.zsh-theme +90
d5d
i
```

```
prompt_context() {
  emojis=("⚡️" "🔥" "💀" "👑" "😎" "🐸" "🐵" "🦄" "🌈" "😄" "🚀" "💡" "🎉" "🔑" "🇹🇭" "🚦" "🌙")
  RAND_EMOJI_N=$(( $RANDOM % ${#emojis[@]} + 1))
  prompt_segment magent black "${emojis[$RAND_EMOJI_N]} "
}
```

```
[return]
[ESC]
:wq
```

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)";\
source ~/.zshrc;\
sed -i '' '36s/8/180/' ~/.zinit/plugins/zsh-users---zsh-autosuggestions/zsh-autosuggestions.zsh
```

![](/media/200212iterm.png)
## pip
```
sudo easy_install pip

pip install powerline-status --user
```

## vim-plug
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## GPG
```
hdiutil attach /Volumes/Catalina/Restore/Password.dmg

sed -n '23p' /Volumes/Password/password.txt

gpg --import /Volumes/Catalina/Restore/secret-backup.gpg
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
信任软件来源
sudo spctl --master-disable

禁用连接设备弹窗
sudo killall -STOP -c usbd

禁用开机音效
sudo nvram SystemAudioVolume=%00

拼写自动纠正
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

禁用 DS_Store
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

设置进入休眠状态时马上启动屏幕保护程序
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

Launchpad 图标数量
defaults write com.apple.dock springboard-columns -int 8; defaults write com.apple.dock springboard-rows -int 8; defaults write com.apple.dock ResetLaunchPad -bool TRUE; killall Dock

减少通知提醒时间
defaults write com.apple.notificationcenterui bannerTime 3

禁用程序崩溃报告
defaults write com.apple.CrashReporter DialogType none

禁用多播广告
sudo defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool YES
```

## duti 设置默认打开程序
```
duti -s com.apple.Safari afp
duti -s com.apple.Safari smb
duti -s org.mozilla.firefox ftp
```

## Sublime Text
```
"font_size": 20,
"font_face": "SourceCodePro-Semibold",
```

## 参考资料
[macOS-Security-and-Privacy-Guide/README-cn.md](https://github.com/xitu/macOS-Security-and-Privacy-Guide/blob/master/README-cn.md)
