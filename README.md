# dotfiles

This is a collection of dotfiles and configuration files that I use in my development process. It also has a script to put these files into place via symbolic links.

## Usage

### Setup a new machine

1. Fork this repository.
2. **Important**: Change the username and email address in `home/.gitconfig` so that you don’t accidentally commit under my name.
3. Run the deploy script.

   ```sh
   ./deploy.sh
   ```

   This will create symbolic links in your home directory to all files in the repository’s `home` directory. It will also attempt to install software that I regularly use for development (e.g. Z shell, Oh My Zsh, Z shell plugins, etc.).

### Update files in the repository

Use the collect script to backup configuration files for [Visual Studio Code](https://code.visualstudio.com/) and [Albert](https://github.com/albertlauncher/albert).

```sh
./collect.sh
```
