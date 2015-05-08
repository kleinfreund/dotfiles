# dotfiles

Better have them somewhere in case the hard drive dies again. These are not only dotfiles. I also backup my text editor configuration, etc. with this.

```bash
bash get-dotfiles.sh
```

## To Do

- Add `$NPM_DIR` for OS X/Linux

## Sublime Text projects act crazy after using the shell script

I noticed that the usage of the shell script conflicts with Sublime Text projects for some reason. Affected projects won't show open files or one will not be able to use the sidebar entries. To fix this, I have to open the *.sublime-project files from the file explorer. WAT.
