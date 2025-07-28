# dotfiles

Clone your dotfiles into a hidden bare repo
```
git clone --bare git@github.com:yourusername/dotfiles.git $HOME/.dotfiles
```

Define a Git alias for ease
```
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

Checkout your config files
```
dotfiles checkout
```

Avoid tracking untracked files
```
dotfiles config --local status.showUntrackedFiles no
```

## Downloading secrets

Two zsh functions are provided to download and upload secrets from the 1password vault: `download_secrets` and `upload_secrets`.
One password CLI can't be managed in home-manager because the desktop app refuses to communicate with the nix managed CLI.
