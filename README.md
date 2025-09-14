# Neovim
Minimalist Neovim setup for C# development:
- Omnisharp LSP integration via Mason
- C# debugging via `netcoredbg`

# Fonts
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


# Zshrc
```
# zodide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# zsh-autosuggestions via oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# powerlevel10k via oh-my-zsh
git clone --depth=1 https://github.com/romkatv/powe nvm install node
rlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
ln -s ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ${HOME}/powerlevel10k

```

# post-install.sh steps
In a new shell run:
```
nvm install node
```
