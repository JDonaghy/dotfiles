#!/bin/bash

if [ 0 = `which brew | wc -l` ]; then
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  touch $HOME/.bashrc
  echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.bashrc
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  brew bundle install --file $HOME/src/dotfiles/brew/Brewfile 
fi

# TODO: For monitor not working after resume bug 
# https://askubuntu.com/questions/1333688/how-to-get-external-monitor-to-reconnect-after-sleep-or-power-off/1427781#1427781
pushd $HOME
rm -rf .bash_profile .bash_logout .bashrc .zprofile .zshrc .tmux .config/nvim Brewfile
pushd src/dotfiles
stow -t ~ nvim
stow -t ~ bash
stow -t ~ zsh
stow -t ~ tmux
stow -t ~ brew
popd
mkdir -p .nvm
popd

rm -rf ~/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mkdir -p ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
ln -s ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ${HOME}/powerlevel10k
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
