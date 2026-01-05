# Atef Ben Ali Dotfiles

My dotfiles

Inspired by `Grégoire Pineau` [dotfiles](https://github.com/lyrixx/dotfiles).

### Automated Interactive Installation

Use the provided interactive installation script for easy setup:

```bash
# Download and run the installation script
curl -sL https://raw.githubusercontent.com/atefBB/dotfiles/main/install.sh | bash

# Or clone and run locally
git clone https://github.com/atefBB/dotfiles.git
cd dotfiles
chmod +x install.sh
./install.sh
```

### fish

Put `fish_functions` folder content in `~/.config/fish/functions` folder.

### Neovim

- place `init.vim` file in `~/.config/nvim` folder
- install
  [vim-plug](https://github.com/junegunn/vim-plug?tab=readme-ov-file#neovim)
- restart nvim & install plugins using vim-plug

### Todo

- improve `readme` file
