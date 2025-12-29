# Dotfiles and other config for setting up a new installation of Linux/WSL

## Setup
```bash
pushd $HOME
mkdir -p src
pushd src
if [ ! -d "dotfiles" ]; then
    wget -O dotfiles.zip https://github.com/JDonaghy/dotfiles/archive/refs/heads/develop.zip
    unzip dotfiles.zip
    mv dotfiles-develop dotfiles
fi
popd
popd
```

## Installation on regular Ubuntu Linux/WSL
```bash
cd $HOME/src/dotfiles
./post-install.sh
```

## Installation on Immutable Linux
### Requirements
- Distrobox
- Linux Homebrew 
- Podman

Run the following on the host:
```bash
cd $HOME/src/dotfiles/distrobox
./host-install.sh
podman build --tag ubuntu-dev-image .
podman images
#if image is built but untagged run:
#podman tag IMAGE_ID ubuntu-dev-image:latest
distrobox create --name ubuntu-dev-image --image ubuntu-dev-image --volume /home/linuxbrew:/home/linuxbrew:rw
```

To connect to your distrobox image:
```
distrobox enter ubuntu-dev-jd
```


## Fonts
Source: https://gist.github.com/matthewjberger/7dd7e079f282f8138a9dc3b045ebefa0#file-instructions-md

- Download a [Nerd Font](http://nerdfonts.com/)
- Unzip and copy to `~/.fonts`
- Run the command `fc-cache -fv` to manually rebuild the font cache

E.g.
```
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/DroidSansMono.zip
unzip DroidSansMono.zip -d ~/.fonts
fc-cache -fv
```


## Zshrc
```
# zodide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# zsh-autosuggestions via oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# powerlevel10k via oh-my-zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
ln -s ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ${HOME}/powerlevel10k

```

