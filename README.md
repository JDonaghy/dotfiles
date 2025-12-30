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
Note that this should work on regular Linux as well provided the requirements are met.
### Requirements
The following need to be pre-installed on the system. 
- [Distrobox](https://distrobox.it)
- [Homebrew on linux](https://docs.brew.sh/Homebrew-on-Linux)
- [Podman](https://podman.io/)

### rpm-ostree
For missing packages that can't be installed via Flatpak or Homebrew in Fedora Silverblue, Kinoite etc. E.g.
```
rpm-ostree install alacritty # and reboot
```

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

To connect to your distrobox guest container:
```
distrobox enter ubuntu-dev-image
```

## Post-installation
If you don't already have an SSH key generate a [new ssh one for Github](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent), sign into your Github account and upload it.
```
git config --global user.name "John Doe"
git config --global user.email "johndoe@email.com"
cd $HOME/src/
mv dotfiles dotfiles-bak
git clone git@github.com:JDonaghy/dotfiles.git
```

## Miscellaneous
### Nerd Fonts
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


