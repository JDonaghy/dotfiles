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
  virt-manager \
  zsh \
  libxss1 \
  cpu-checker \
  unzip

read -r -p "Install KVM? [y/N] " response
case "$response" in
    [yY]) 
        sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager
        sudo adduser $USER libvirt
        sudo adduser $USER kvm
        sudo systemctl enable --now libvirtd
        sudo systemctl status libvirtd
        ;;
    *)
        ;;
esac

# Google Chrome
pushd $HOME/Downloads
if [ 0 = `which google-chrome | wc -l` ]; then
  wget https://dl.google.com/linux/direct/
  sudo apt install ./google-chrome*.deb
fi
popd

# Homebrew
if [ 0 = `which brew | wc -l` ]; then
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew install \
  binutils \
  eza \
  gettext \
  icu4c@76 \
  k9s \
  lazygit \
  libgit2 \
  libnsl \
  libtirpc \
  libvterm \
  lpeg \
  luv \
  mpfr \
  ncurses \
  oh-my-posh \
  powerlevel10k \
  tree-sitter \
  xz \
  zsh-autocomplete \
  ca-certificates \
  gcc \
  gmp \
  isl \
  krb5 \
  libedit \
  libmpc \
  libssh2 \
  libuv \
  libxml2 \
  luajit \
  lz4 \
  msgpack \
  neovim \
  openssl@3 \
  readline \
  unibilium \
  zlib \
  zstd \
  helm \
  kubectl

# dotnet
if [ 0 = `which dotnet | wc -l` ]; then
  sudo apt install -y dotnet8 
  dotnet tool install --global dotnet-script
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mkdir -f ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
