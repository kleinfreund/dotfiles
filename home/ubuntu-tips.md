# Ubuntu Setup Tips

Setting up a newly installed operating system can become frustrating quickly. Especially when it was forced upon ourselves (e.g. the hard drive died again). This is a collection of tips that are part of my backup strategy. Here, I try to document what things I configure with my operating system, what software I install, etc. This is highly opinionated. This setup works for me but might not for you.

**Note**: In this document, `o` is an alias for the editor that is used. One can use `gedit` on a new system or alias a custom one with `alias o=vim`.



## General Ubuntu Settings

When something was configured via `gsettings set`, this can be reverted back to its original state via `gsettings reset`.

### Global file associations

Ubuntu uses gedit as its default text editor. To associate files that are opened in gedit with another program, one needs to update the file `/usr/share/applications/defaults.list`. Replace all occurences of `gedit.desktop` with the file name that is being associated with your preferred application. The new file name needs to refer to a file that exists in the same directory, e.g.:

- `sublime_text.desktop`
- `code.desktop`
- `vim.desktop`

```
sudo sed -i 's/gedit.desktop/code.desktop/g' /usr/share/applications/defaults.list
```

**Note**: One is able to override these global settings by configuring a application for each file type by opening its properties and changing the default application under *Open With*. Changing these can be done via a command-line interface.

**Prints the current setting**:

```
xdg-mime query default text/plain
```

**Changes the association**:

```
xdg-mime default code.desktop text/plain
```

### Disable touchpad when mouse is connected

```
gsettings set org.gnome.desktop.peripherals.touchpad send-events disabled-on-external-mouse
```

### Disable locking when closing laptop lid

```
sudo sed -i 's/IgnoreLid=false/IgnoreLid=true/g' /etc/UPower/UPower.conf
service upower restart
```

### Disable tab/application switch on scrolling

I don’t like the Ubuntu behavior of switching applications/tabs when scrolling in some specific areas. Sadly, this can’t be disabled for *Google Chrome* and *Gnome Terminal*.

**Sublime Text: User Preferences**:

```
"mouse_wheel_switches_tabs": false
```

### Show date in top bar

```
gsettings set com.canonical.indicator.datetime show-date true
```

### Disable Screenshot Sound

```
sudo mv /usr/share/sounds/freedesktop/stereo/screen-capture.oga /usr/share/sounds/freedesktop/stereo/screen-capture-disabled.oga
```

### Disable wallpaper dots on login screen

```
sudo xhost +SI:localuser:lightdm
sudo su lightdm -s /bin/bash
gsettings set com.canonical.unity-greeter draw-grid false
```

### Load default Alsamixer configuration on autostart

Configure volume levels, etc.

```
alsamixer
```

Store these settings in a file

```
alsactl --file ~/.config/asound.state store
```

Create an autostart entry ...

```
o ~/.config/autostart/alsa-restore.desktop
```

with the following content ...

```
[Desktop Entry]
Type=Application
Terminal=false
Name=alsarestore
Exec=bash -c "sleep 3 && alsactl --file ~/.config/asound.state restore"
```

## Keybindings

### Ctrl-Alt-Up/Down

<kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>ArrowUp</kbd>/<kbd>ArrowDown</kbd> are used to switch workspaces. To be able to use them in other applications (e.g. Sublime Text), you can disable them like this:

```
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['']"
```

## Disable mouse wheel click to minimize window

```
gsettings set org.gnome.desktop.wm.preferences action-middle-click-titlebar 'none'
```





## Software

### Google Chrome

- As per answer to [Ask Ubuntu: How to install Google Chrome](https://askubuntu.com/a/510186)

```
wget -qO - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt update
sudo apt install google-chrome-stable
```

### `git`

```
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get install git
```

### Sublime Text, `subl` (code editor)

- [Sublime Text website](https://www.sublimetext.com)

```
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
echo "deb https://download.sublimetext.com/ apt/dev/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt update
sudo apt install sublime-text
```

### `gnome-tweak-tool`

```
sudo apt update
sudo apt install gnome-tweak-tool
```

#### Disable Caps Lock

- Open “Tweak Tool”
- Select category “Typing”
- Select “Caps Lock key behavior”
- Select “Caps Lock is disabled”

#### Enable selecting via Ctrl+Pos1/End

- Open “Tweak Tool”
- Select category “Typing”
- Select “Miscellaneous compatibility options”
- Select “Numlock on: digits, shift switches to arrow keys, Numlock off: always arrow keys (as in MS Windows)”

### CompizConfig Settings Manager

```
sudo apt update
sudo apt install compizconfig-settings-manager
```

#### Application Switcher

- Next window (All windows): `<Alt>Tab`
- Prev window (All windows): `<Shift><Alt>Tab`

#### Grid

- Map all “Put … Key” actions to numpad
- Maximize Key: `<Super>Up`
- Restore: `<Super>Down`
- Left Maximize: `<Super>Left`
- Right Maximize: `<Super>Right`

### `ag` (command line search, faster than `ack`)

- [GitHub repository](https://github.com/ggreer/the_silver_searcher)

```
sudo apt install silversearcher-ag
ag "thing to search for" /path/to/search/in
```

### `htop` (command line activity monitor)

```
sudo apt install htop
htop
```

### `mascii`, `telnet mapscii`

- [GitHub repository](https://github.com/rastapasta/mapscii)
- Usage via telnet: `telnet mapscii.me`

```
npm install -g mapscii
mapscii
```

### Zsh & Oh My Zsh

- [Oh My Zsh website](http://ohmyz.sh/)

```
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```





## Dracula Theme

### Sublime Text

- Open “Package Control: Install Package”
- Install “Dracula Color Scheme”

### ZSH

```
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
o ~/.zshrc
```

Add the plugin like this:

```
plugins=([plugins...] zsh-syntax-highlighting)
```

### Gnome Terminal Colors

The [Dracula Theme](https://draculatheme.com/) is available for a variety of applications. Using it in Sublime Text is as easy as installing the package.

Applying it to Gnome Terminal is done by executing an install as follows:

```
git clone git@github.com:dracula/gnome-terminal.git dracula-gnome-terminal
cd dracula-gnome-terminal
./install.sh -s Dracula -p default
```

Alternatively, the web tool [terminal.sexy](https://terminal.sexy) can be used to convert the macOS Terminal theme to a Gnome Terminal theme.

- Download `Dracula.terminal` from https://github.com/dracula/terminal.app (that’s for the macOS’ Terminal.app)
- Open [terminal.sexy](https://terminal.sexy)
  - Import > Format: Terminal.app
  - Paste the contents of `Dracula.terminal` into the text box
  - Click “Import”
  - Export > Format: Gnome Terminal
  - Click “Export”
  - Download the file
  - Add the colors via adding a new profile by running the downloaded file as a script:

```
mv terminal.sexy.txt dracula.sh
sed -i 's/terminal.sexy/Dracula/g' dracula.sh
sed -i 's/terminal-dot-sexy/Dracula/g' dracula.sh
chmod +x dracula.sh
./dracula.sh
```

- Open Terminal
- Preferences > Profiles > Profile used when launching a new terminal: `terminal.sexy`



## Miscellaneous

### Font: Fira Code

- [GitHub repository](https://github.com/tonsky/FiraCode)

### Mount Windows partition:

When mounting the Windows partition, an error like this might appear:

```
$ sudo mount -t "ntfs" -o remove_hiberfile "/dev/sda4" "/media/phil/Boot"
The disk contains an unclean file system (0, 0).
Metadata kept in Windows cache, refused to mount.
Failed to mount '/dev/sda4': Operation not permitted
The NTFS partition is in an unsafe state. Please resume and shutdown
Windows fully (no hibernation or fast restarting), or mount the volume
read-only with the 'ro' mount option.
```

The `ntfsfix` command can be used to make it mountable if Windows is not in fact hibernated.

```
sudo ntfsfix /dev/sda4
```

Alternatively, the hibernation file can be deleted:

```
sudo mount -t "ntfs" -o remove_hiberfile "/dev/sda4" "/media/phil/Boot"
```

### Simple static HTTP Server

```
python3 -m http.server 8000
```

```
server() {
  local port="${1:-8080}"
  # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
  # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
  python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
  xdg-open "http://localhost:${port}/"
}
```
