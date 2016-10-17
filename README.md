# config & dotfiles

This repository serves as a backup tool for my configuration and dotfiles. Everything inside here is opinionated but you should be able to run it on your system as well. In its current state, the script does not modify anything outside of the repository it’s meant to be run from.

Getting started should be as easy as setting up a new Git repository, placing the script inside the root and running it like so:

```bash
./get-dotfiles.sh
```

## Compatibility

Windows does not natively support shell scripts. Running this script inside the native command line (cmd.exe, PowerShell, etc.) will not work. I am currently using Git Bash as my command line interface which runs Bash 3.1.20. I’d prefer to run version 4, since I could use associative arrays in the script then. Currently I am worried about basic compatibility when moving to new systems, so I leave it at that.

**Update** Current Git Bash should have Bash version 4, but I moved to using Cmder together with the Linux subsystem for windows.

## To Do

- Add `$NPM_DIR` for OS X/Linux
- (Consideration) Store actual config files in `~/.config` and symlink them
