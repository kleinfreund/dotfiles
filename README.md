# dotfiles

## Usage

```sh
git clone git@github.com:kleinfreund/dotfiles.git
cd dotfiles
```

Use the deploy script to create symbolic links in `$HOME` to all files in this repositories' `home/` directory.

```sh
./deploy.sh
```

Use the collect script to backup configuration files of Sublime Text and Visual Studio Code.

```sh
./collect.sh
```
