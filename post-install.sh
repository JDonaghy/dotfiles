#!/bin/bash

sudo apt update
sudo apt upgrade -y

sudo apt install -y \
  build-essential \
  cmake \
  alacritty \
  fd-find \
  git \
  procps \
  curl \
  file \
  keepassxc \
  nmap \
  python3-pip \
  ripgrep \
  sharutils \
  tmux \
  vim \
  zsh \
  libxss1 \
  cpu-checker \
  unzip

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Homebrew
if [ 0 = `which brew | wc -l` ]; then
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# dotnet
if [ 0 = `which dotnet | wc -l` ]; then
  sudo apt install -y dotnet8 
  dotnet tool install --global dotnet-script
  wget https://github.com/Samsung/netcoredbg/releases/download/3.1.2-1054/netcoredbg-linux-amd64.tar.gz
  tar -xvf netcoredbg-linux-amd64.tar.gz
  chmod u+x netcoredbg/netcoredbg
  mv netcoredbg/* $HOME/.local/bin
  rmdir netcoredbg
  
  mkdir -p $HOME/.local/bin
  mv netcoredbg/* $HOME/.local/bin

fi

# TODO: For monitor not working after resume bug 
# https://askubuntu.com/questions/1333688/how-to-get-external-monitor-to-reconnect-after-sleep-or-power-off/1427781#1427781
pushd $HOME
rm -rf .bash_profile .bash_logout .bashrc .zprofile .zshrc .tmux .p10k.zsh .config/nvim Bre
pushd src/dotfiles
stow -t ~ nvim
stow -t ~ bash
stow -t ~ zsh
stow -t ~ tmux
stow -t ~ brew
stow -t ~ powerlevel10k
popd
popd

brew bundle install

rm -rf ~/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mkdir ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
ln -s ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ${HOME}/powerlevel10k
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
