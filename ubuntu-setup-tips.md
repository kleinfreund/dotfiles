# Ubuntu setup tips

This document contains a collection of tips for setting up certain things on a newly installed copy of Ubuntu that I might forget about.

## General settings

**Tip**: When something was configured via `gsettings set`, this can be reverted back to its original state
via `gsettings reset`.

### Global file associations

Ubuntu uses gedit as its default text editor. To associate files that are opened in gedit with
another program, one needs to update the file `/usr/share/applications/defaults.list`. Replace all
occurences of `gedit.desktop` with the file name that is being associated with your preferred
application. The new file name needs to refer to a file that exists in the same directory, e.g.:

- `sublime_text.desktop`
- `code.desktop`
- `vim.desktop`

```sh
sudo sed -i 's/gedit.desktop/code.desktop/g' /usr/share/applications/defaults.list
```

**Note**: One is able to override these global settings by configuring an application for each file
type. This is done by opening its properties and changing the default application under _Open With_. Changing
these can be done via a command-line interface.

**Print the current setting for a certain content type**:

```sh
xdg-mime query default text/plain
```

**Changes the default association for a certain content type**:

```sh
xdg-mime default code.desktop text/plain
```

### Disable screenshot sound

```sh
sudo mv /usr/share/sounds/freedesktop/stereo/screen-capture.oga /usr/share/sounds/freedesktop/stereo/screen-capture-disabled.oga
```

## Keyboard shortcuts

### Ctrl-Alt-Up/Down

<kbd>Ctrl</kbd>-<kbd>Alt</kbd>-<kbd>ArrowUp</kbd>/<kbd>ArrowDown</kbd> are used to switch
workspaces. To be able to use them in other applications (e.g. Sublime Text), you can disable them
like this:

```
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['']"
```

## Disable mouse wheel click to minimize window

```
gsettings set org.gnome.desktop.wm.preferences action-middle-click-titlebar 'none'
```

## Software

### Firefox

```sh
sudo snap install firefox
```

To switch to the beta channel:

```sh
sudo snap switch --channel=beta firefox
sudo snap refresh
```

### Visual Studio Code

```sh
sudo snap install vscode --classic
```

### Sublime Text

```sh
sudo snap install sublime-text --classic
```

### Google Chrome

For installing Chrome with `apt` look at this answer to [Ask Ubuntu: How to install Google Chrome](https://askubuntu.com/a/510186)

### VLC

```sh
sudo snap install vlc
```

### Inkscape

```sh
sudo snap install inkscape
```

### git

```sh
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update && sudo apt-get install git
```

### htop

```sh
sudo snap install htop
```

### ag (command line search, faster than `ack`)

- [GitHub repository](https://github.com/ggreer/the_silver_searcher)

```sh
sudo apt install silversearcher-ag
ag "thing to search for" /path/to/search/in
```

### bat

- [GitHub repository](https://github.com/sharkdp/bat)

```sh
wget https://github.com/sharkdp/bat/releases/download/v0.15.0/bat_0.15.0_amd64.deb
sudo dpkg -i bat_0.11.0_amd64.deb
```

### node

```sh
sudo snap install node --channel=14/stable --classic
```

List global packages:

```sh
npm list -g --depth=0
```

Install global packages:

```sh
npm i -g eslint http-server npm-check-updates svgo tldr
```

### gnome-tweak-tool

```sh
sudo apt update
sudo apt install gnome-tweak-tool
```

### Flameshot

- [GitHub repository](https://github.com/lupoDharkael/flameshot)

```sh
sudo apt update
sudo apt install flameshot
```

### Peek

- [GitHub repository](https://github.com/phw/peek)

```sh
sudo add-apt-repository ppa:peek-developers/stable
sudo apt update
sudo apt install peek
```

#### Disable Caps Lock

- Open “Tweak Tool”
- Select category “Typing”
- Select “Caps Lock key behavior”
- Select “Caps Lock is disabled”

#### Enable selecting via Ctrl-Pos1/End

- Open “Tweak Tool”
- Select category “Typing”
- Select “Miscellaneous compatibility options”
- Select “Numlock on: digits, shift switches to arrow keys, Numlock off: always arrow keys (as in MS
  Windows)”
