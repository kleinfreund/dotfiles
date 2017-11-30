# dotfiles

Use the deploy script to create symbolic links in `$HOME` to all files in `home/`.

```bash
./deploy.sh
```

Use the collect script to backup configuration files of Sublime Text and Visual Studio Code.

```bash
./collect.sh
```

## Adding a new ZSH plugin as a submodule

```
git submodule add https://github.com/zsh-users/zsh-syntax-highlighting zsh/plugins/zsh-syntax-highlighting
git submodule add https://github.com/zsh-users/zsh-autosuggestions zsh/plugins/zsh-autosuggestions
git submodule init
```

Then, add the plugins to `.zshrc`:

```
plugins=(
  zsh-syntax-highlighting
  zsh-autosuggestions
)
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
