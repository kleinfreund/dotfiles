# dotfiles

## Usage

```sh
git clone --recurse-submodules git@github.com:kleinfreund/dotfiles.git
cd dotfiles
```

If you forgot to clone with the `--recurse-submodules` argument, you can get them with this:

```sh
git submodule update --init
```

Use the deploy script to create symbolic links in `$HOME` to all files in this repositories' `home/` directory.

```sh
./deploy.sh
```

Use the collect script to backup configuration files of Sublime Text and Visual Studio Code.

```sh
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

```sh
git submodule update --recursive --remote
```

## Removing a submodule

```sh
git submodule deinit -f zsh/plugins/zsh-syntax-highlighting
rm -rf .git/modules/zsh/plugins/zsh-syntax-highlighting
git rm -f zsh/plugins/zsh-syntax-highlighting
git config -f .git/config --remove-section submodule.zsh/plugins/zsh-syntax-highlighting
git config -f .gitmodules --remove-section submodule.zsh/plugins/zsh-syntax-highlighting
```
