# dotfiles

Better have them somewhere in case the hard drive dies again. These are not only dotfiles. I also backup my text editor configuration, etc. with this.

Remember to close Sublime Text before running the script, otherwise it seems to mess with the `sublime-workspace` files and makes the file tree in the sidebar unusable.

```bash
bash ./get-dotfiles.sh
```

## Compatibility

Windows does not natively support shell scripts. Running this script inside `cmd.exe` will not work. I am currently using Git Bash as my command line interface which runs Bash 3.1.20. I’d prefer to run version 4, since I could use associative arrays in the script then. Currently I am worried about basic compatibility when moving to new systems, so I leave it at that.

## To Do

- Add `$NPM_DIR` for OS X/Linux
