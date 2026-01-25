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
  unzip \
  stow

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Homebrew
if [ 0 = `which brew | wc -l` ]; then
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# dotnet
if [ 0 = `which dotnet | wc -l` ]; then
  sudo apt install -y dotnet8 
  dotnet tool install --global dotnet-script
  rm -rf netcoredbg*.gz
  wget https://github.com/Samsung/netcoredbg/releases/download/3.1.3-1062/netcoredbg-linux-amd64.tar.gz
  tar -xvf netcoredbg-linux-amd64.tar.gz
  chmod u+x netcoredbg/netcoredbg
  mkdir -p $HOME/.local/bin
  mv netcoredbg/* $HOME/.local/bin
  rm -rf netcoredbg*
fi

# TODO: For monitor not working after resume bug 
# https://askubuntu.com/questions/1333688/how-to-get-external-monitor-to-reconnect-after-sleep-or-power-off/1427781#1427781
pushd $HOME
rm -rf .bash_profile .bash_logout .bashrc .zprofile .zshrc .tmux.conf .p10k.zsh .config/nvim Brewfile
pushd src/dotfiles
stow -t ~ nvim
stow -t ~ bash
stow -t ~ zsh
stow -t ~ tmux
stow -t ~ brew
stow -t ~ powerlevel10k
popd
popd

brew bundle install --file $HOME/Brewfile

rm -rf ~/.oh-my-zsh

pushd /tmp
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh ./install.sh --unattended
rm ./install.sh
popd

mkdir ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
ln -s ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ${HOME}/powerlevel10k
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

if [ 0 = `which google-chrome | wc -l` ]; then
  pushd $HOME/downloads
  rm google-chrome*.deb
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo apt install -y ./google-chrome-stable_current_amd64.deb
  rm ./google-chrome-stable_current_amd64.deb
  popd
fi
