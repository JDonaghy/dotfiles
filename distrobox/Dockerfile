FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Update the package lists and install the required development tools
RUN apt-get update && apt-get install -y \
  build-essential \
  cmake \
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
  stow \
  unzip && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

