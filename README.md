# dotfiles

Copy dotfiles to this git repository.

```bash
./get-dotfiles.sh
```

This repository serves as a backup tool for my configuration and dotfiles.

## Adding a new ZSH plugin as a submodule

```
git submodule add https://github.com/zsh-users/zsh-syntax-highlighting zsh/plugins/zsh-syntax-highlighting
git submodule add https://github.com/zsh-users/zsh-autosuggestions zsh/plugins/zsh-autosuggestions
```

```
git submodule init
```

## Update all submodules

```
git submodule foreach git pull
```

## Removing a submodule

```
git submodule deinit -f zsh/plugins/zsh-syntax-highlighting
rm -rf .git/modules/zsh/plugins/zsh-syntax-highlighting
git rm -f zsh/plugins/zsh-syntax-highlighting
git config -f .git/config --remove-section submodule.zsh/plugins/zsh-syntax-highlighting
git config -f .gitmodules --remove-section submodule.zsh/plugins/zsh-syntax-highlighting
```
